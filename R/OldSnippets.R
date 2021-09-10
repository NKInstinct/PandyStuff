# #2020-06-07
# library(tidyverse)
# 
# mtgcards <- read_csv("list to upload 6 3.csv",col_types = "dccdddccccdccccccccccc")
# 
# #Zero in stock at Irenee's request
# mtgcards <- mtgcards %>%
#   mutate(`In stock` = 0)
# 
# 
# testMTG <- mtgcards %>%
#   dplyr::filter(`Set Stock` > 0) %>%
#   dplyr::rename(`Card Name` = "Card Name [real]")
# write_csv(testMTG, "onlyStock.csv", na = "")


# library(qrcode)
# 
# {
# svg("PandyEvents.svg")
# qrcode_gen("https://pandemoniumbooks.com/apps/bookthatapp/calendar")
# dev.off()
# }
# 
# {
# png("PandyEvents.png")
# qrcode_gen("https://pandemoniumbooks.com/apps/bookthatapp/calendar")
# dev.off()
# }


# #2020-06-14 Table Merger
# 
# library(tidyverse)
# library(readxl)
# 
# df1 <- read_excel("product-export.xlsx") %>%
#   dplyr::select("Handle" = handle, supplier_code) %>%
#   mutate(Handle = tolower(Handle))
# 
# df2 <- read_csv("backup paints 6 14.csv") %>%
#   mutate(Handle = tolower(Handle))
# 
# result <- left_join(df2, df1, by = "Handle")
# 
# write_csv(result, "Joined Paint Table.csv", na = "")