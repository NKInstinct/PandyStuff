#' QRCoder
#' 
#' Generate QR codes for any user-inputted text. Also supports specifying a
#' certain level of QR code quality (error handling). Higher-quality QR codes
#' can have more of their information obscured (by graphics or weird camera
#' artefacts) and still be used, but are more complex and so might not be
#' suitable for very long strings of text.
#' 
#' Generated codes can be downloaded to the user's computer. Currently, only
#' .png downloads are supported, but other file formats may be possible as
#' needed.
#' 
#' @import shiny
#'
#' @export
QRCoder <- function(...){
  ui <- fluidPage(
    titlePanel("QR Code Generator"),
    sidebarLayout(
      sidebarPanel(
        textInput("codeStr", "Enter string to turn into QR code here:"),
        radioButtons("errorButton", 
                     "Error Tolerance",
                     choiceNames = list("Low",
                                        "Medium",
                                        "High",
                                        "Highest"),
                     choiceValues = list("L",
                                         "M",
                                         "Q",
                                         "H"),
                     selected = "Q"),
        actionButton("codeConfirm", "Encode!"),
        downloadButton("download", "Download QR code")
      ),
      mainPanel(
        plotOutput("qrplot")
      )
    )
  )
  
  server <- function(input, output, session) {
    QR <- reactive(qrcode::qrcode_gen(input$codeStr, 
                                      plotQRcode = FALSE, 
                                      dataOutput = TRUE,
                                      ErrorCorrectionLevel = input$errorButton))
    HMap <- eventReactive(input$codeConfirm, {
      heatmap(QR(), 
              Colv = NA, 
              Rowv = NA, 
              revC = TRUE, 
              labRow = "", 
              labCol = "", 
              col = grey.colors(2, start = 1, end = 0))
    })
    
    output$qrplot <- renderPlot(HMap())
    
    output$download <- downloadHandler(
      filename = function(){
        paste0("QRCode_",
               stringr::str_remove_all(input$codeStr, "\\W*"),
               ".png")
      },
      content = function(file){
        png(file)
        heatmap(QR(), 
                Colv = NA, 
                Rowv = NA, 
                revC = TRUE, 
                labRow = "", 
                labCol = "", 
                col = grey.colors(2, start = 1, end = 0))
        dev.off()
      }
    )
  }
  
  shinyApp(ui, server)
}
