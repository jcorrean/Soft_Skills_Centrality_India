# Step 1: Opening the sample of texts
# this local folder is a clone of the GitHub Repo
library(readtext)
textos <- readtext("Raw Data/INDIA/")
textos$doc_id <- gsub("[^0-9_-]", "", textos$doc_id)
# The following code allows us  to 
# classify the type of program (e.g., Master or doctorate)
# for each program. We need to check the correct 
# classification 
library(dplyr)
textos <- mutate(textos, 
                 Program = ifelse(
                   grepl("Bachel", text), "Bachelor",
                   ifelse(grepl("Master", text), "Master", 
                          ifelse(grepl("MBA", text), "Master", 
                                 "Doctorate"))))

library(quanteda)
Textos <- corpus(textos)

Programs <- tokens(Textos, 
                     remove_numbers = TRUE, 
                     remove_punct = TRUE, 
                     remove_url = TRUE, 
                     remove_symbols = TRUE) %>%  
  tokens_remove(stopwords("english"))

save.image("Results/INDIA/Result1.RData")

