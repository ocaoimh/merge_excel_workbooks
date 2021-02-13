#this cleans up your global environment (optional)
rm(list = ls())

#library(tidyverse)
library(readxl)
#library(xlsx) for writing to xlsx
library(data.table)
library(xlsx) 
         

setwd("~/UXR/survey_masters_el/my_data") 

# list the excel files and produce a character vector 
file.list <- list.files(pattern = '*.xlsx')
file.list <- setNames(file.list, file.list)

#takes file.list and read the data from the first worksheet of each workbook and copies this into our file.list
df.list <- lapply(file.list, read_excel, sheet = 1)

#take each workbook and join them together
df.list <- Map(function(df, name) {
  df$source_name <- name
  df
}, df.list, names(df.list))
df <- rbindlist(df.list, idcol = "id", fill = TRUE)

#write.xlsx(df, "group1.xlsx")

# write your merged workbooks into one! 
write.csv(df, "all_surveys_elearning_jan_2021.csv")

