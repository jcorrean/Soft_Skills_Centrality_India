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
Texts <- data.frame(summary(Textos, n = length(Textos)))

Programs <- tokens(Textos, 
                     remove_numbers = TRUE, 
                     remove_punct = TRUE, 
                     remove_url = TRUE, 
                     remove_symbols = TRUE) %>%  
  tokens_remove(stopwords("english"))

library(dplyr)
textos$Type_of_Institute <-  recode(textos$Type_of_Institute, 
                                        "Amravati University" = "State University", 
                                        "University of Mumbai" = "State University", 
                                        "central university" = "Central University",
                                        "Autonomous University" = "Institute of National Importance",
                                        "Public Technical University" = "Institute of National Importance",
                                        "University of Mumbai" = "State University",
                                        "University Of Mumbai" = "State University")

table(textos$Type_of_Institute)

textos$InstitutionCategory <-  textos$Type_of_Institute %>% recode(., "Private University" = "PU", 
                                                                           "State University" = "SU", 
                                                                           "Central University" = "CU",
                                                                           "Institute of National Importance" = "INI",
                                                                           "Deemed University" = "DU")

table(textos$InstitutionCategory)

table(textos$Program)


CT <- table(textos$Program,textos$InstitutionCategory)
print(CT)

length(table(textos$Institute_Name))

library(treemap)
SampledPrograms <- data.frame(CT)
variable.names(SampledPrograms)
colnames(SampledPrograms)[1] <- "Program"
colnames(SampledPrograms)[2] <- "Institution"
colnames(SampledPrograms)[3] <- "value"


library(treemap)
png("F00.png", width = 15, height = 7, units = 'in', res = 300)
treemap(SampledPrograms,
        index=c("Program","Institution"),
        vSize="value",
        vColor = "Program",
        type="index",
        title = "",
        algorithm = "pivotSize",
        mirror.x = TRUE,
        mirror.y = FALSE,
        palette = "Set2")
dev.off()

png("F0.png", width = 15, height = 7, units = 'in', res = 300)
tm <- treemap(SampledPrograms,
     index=c("Program","Institution"),
     vSize="value",
     type="index",
     title = "",
     algorithm = "pivotSize",
     mirror.x = TRUE,
     mirror.y = FALSE,
     palette = "Set2",
     vColor = Program,
     fontsize.labels=c(0,10)) # Only display labels for "Institution", not "Program"
dev.off()

save.image("Results/Result1.RData")
