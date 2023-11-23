# Step 1: Opening the sample of texts
# this local folder is a clone of the GitHub Repo
library(readtext)
textos <- readtext("INDIA/")
textos$doc_id <- gsub("[^0-9_-]", "", textos$doc_id)
# The following code allows us  to 
# classify the type of program (e.g., Master or doctorate)
# for each program. We need to check the correct 
# classification 
library(dplyr)
textos <- mutate(textos, 
                 Program = ifelse(
                   grepl("Bachel", text), "Bachelor",
                   "Postgraduate"))

library(quanteda)
Textos <- corpus(textos$text)
docvars(Textos, "Program") <- textos$Program

Programs <- tokens(Textos, 
                     remove_numbers = TRUE, 
                     remove_punct = TRUE, 
                     remove_url = TRUE, 
                     remove_symbols = TRUE) %>%  
  tokens_remove(stopwords("english"))

save.image("Results/Result1.RData")

