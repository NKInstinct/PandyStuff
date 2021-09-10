#2020-06-07
library(tidyverse)

mtgcards <- read_csv("list to upload 6 3.csv",col_types = "dccdddccccdccccccccccc")

#Zero in stock at Irenee's request
mtgcards <- mtgcards %>%
  mutate(`In stock` = 0)


testMTG <- mtgcards %>%
  dplyr::filter(`Set Stock` > 0) %>%
  dplyr::rename(`Card Name` = "Card Name [real]")
write_csv(testMTG, "onlyStock.csv", na = "")