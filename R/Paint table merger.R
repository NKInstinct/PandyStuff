#2020-06-14 Table Merger

library(tidyverse)
library(readxl)

df1 <- read_excel("product-export.xlsx") %>%
  dplyr::select("Handle" = handle, supplier_code) %>%
  mutate(Handle = tolower(Handle))

df2 <- read_csv("backup paints 6 14.csv") %>%
  mutate(Handle = tolower(Handle))

result <- left_join(df2, df1, by = "Handle")

write_csv(result, "Joined Paint Table.csv", na = "")
