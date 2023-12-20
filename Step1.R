# Step 1: Opening the sample of texts
# this local folder is a clone of the GitHub Repo
library(readtext)
textos <- readtext("INDIA/")
textos$doc_id <- gsub("[^0-9_-]", "", textos$doc_id)
# The following code allows us  to 
# classify the type of program (e.g., Master or doctorate)
# for each program. We need to check the correct 
# classification 
# Now, let's identify these programs
# according to their level (i.e., bachelor, masters, doctorate)
library(readr)
Programs <- read_csv("Programs.csv")
colnames(Programs)[3] <- "doc_id"
textos <- merge(textos, Programs, by = "doc_id")
rm(Programs)
library(dplyr)
textos <- mutate(textos, Program = ifelse(grepl("Bachelor", Program_Name), "Bachelor",
                                   ifelse(grepl("Master", Program_Name), "Master",
                                   ifelse(grepl("Doctor", Program_Name), "PhD",
                                   ifelse(grepl("Ph.D.", Program_Name), "PhD", "Other")))))
table(textos$Program)
textos <- subset(textos, Program != "Other")

table(textos$Program)
table(textos$Type_of_Institute)


library(quanteda)
Textos <- corpus(textos$text)
docvars(Textos, "Program") <- textos$Program
docvars(Textos, "doc_id") <- textos$doc_id

Programs <- tokens(Textos, 
                     remove_numbers = TRUE, 
                     remove_punct = TRUE, 
                     remove_url = TRUE, 
                     remove_symbols = TRUE) %>%  
  tokens_remove(stopwords("english"))

save.image("Results/Result1.RData")
