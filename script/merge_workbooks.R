#this cleans up your global environment (optional)
rm(list = ls())

library(readxl) #this allows you import and extract data from your Excel workbooks
library(data.table) #this library is the most crucial one and applies the functions that list and recombine the data
library(xlsx) # this is optional. It's a tricky library that can break if you don't have the Java Development kit installed
         

setwd("~/UXR/merge_excel_workbooks/my_data") 

# list the excel files and produce a character vector 
file.list <- list.files(pattern = '*.xlsx')
file.list <- setNames(file.list, file.list)

#takes file.list and read the data from the first worksheet of each workbook and copies this into our file.list
df.list <- lapply(file.list, read_excel, sheet = 1)

#take each workbook and join them together into a data table called 'all_files' 
df.list <- Map(function(all_files, name) {
  all_files$source_name <- name
  all_files
}, df.list, names(df.list))
all_files <- rbindlist(df.list, idcol = "id", fill = TRUE)

# uncomment the line below only if you installed "xlsx". It'll merge your workbooks into an excel file
#write.xlsx(df, "group1.xlsx")

# write your merged workbooks into one! 
write.csv(df, "all_surveys_elearning_jan_2021.csv")

