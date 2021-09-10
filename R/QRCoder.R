library(shiny)

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