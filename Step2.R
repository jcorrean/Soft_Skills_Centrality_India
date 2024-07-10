load("Results/Result1.RData")
library(quanteda)
s1 <- data.frame(kwic(Programs, pattern = c(phrase("critical thinking"), 
                                            phrase("think critically"), 
                                            phrase("criticism"),
                                            phrase("understand*"),
                                            phrase("think"), 
                                            phrase("reasoning"))))
s1$Competence <- "Critical Thinking"
s1$SkillCode <- "S1"
s2 <- data.frame(kwic(Programs, pattern = c(phrase("problem solving"),
                                            phrase("solution of problem"),
                                            phrase("resolving conflict"),
                                            phrase("solv*"),
                                            phrase("conflict*"),
                                            phrase("fix*"),
                                            phrase("repair"),
                                            phrase("building"),
                                            phrase("addressing issues"),
                                            phrase("deal with issues"))))
s2$Competence <- "Problem Solving"
s2$SkillCode <- "S2"
s3 <- data.frame(kwic(Programs, pattern = c(phrase("communication"),
                                            phrase("communicat*"),
                                            phrase("talk*"),
                                            phrase("read*"),
                                            phrase("speak*"),
                                            phrase("listen*"),
                                            phrase("argu*"),
                                            phrase("writ*"))))
s3$Competence <- "Communication"
s3$SkillCode <- "S3"
s4 <- data.frame(kwic(Programs, pattern = c(phrase("creativity"),
                                            phrase("create"),
                                            phrase("generate"),
                                            phrase("produce"),
                                            phrase("creation"),
                                            phrase("conceive"),
                                            phrase("propose"))))
s4$Competence <- "Creativity"
s4$SkillCode <- "S4"
s5 <- data.frame(kwic(Programs, pattern = c(phrase("self-awareness"),
                                            phrase("patience"),
                                            phrase("persistence"),
                                            phrase("perseverance"),
                                            phrase("self control"),
                                            phrase("control of emotions"),
                                            phrase("silence"),
                                            phrase("hard work"),
                                            phrase("working hard"),
                                            phrase("empathy"),
                                            phrase("recognition"),
                                            phrase("acknowledge"),
                                            phrase("commit"),
                                            phrase("commitment"))))
s5$Competence <- "Self-Awareness"
s5$SkillCode <- "S5"
s6 <- data.frame(kwic(Programs, pattern = c(phrase("leadership"),
                                            phrase("lead"),
                                            phrase("command"),
                                            phrase("guiding others"),
                                            phrase("leading"),
                                            phrase("envision*"),
                                            phrase("visualize"),
                                            phrase("inspir*"),
                                            phrase("motivat"),
                                            phrase("control*"),
                                            phrase("change"),
                                            phrase("appreciate"),
                                            phrase("manag*"))))
s6$Competence <- "Leadership"
s6$SkillCode <- "S6"
s7 <- data.frame(kwic(Programs, pattern = c(phrase("entrepreneurship"),
                                            phrase("entrepreneur"),
                                            phrase("nudg*"),
                                            phrase("claim"),
                                            phrase("assert"),
                                            phrase("manifest"),
                                            phrase("shar*"),
                                            phrase("coordinat*"),
                                            phrase("undertake"),
                                            phrase("coopera*"),
                                            phrase("adaptability"),
                                            phrase("curiosity"),
                                            phrase("curiousness"),
                                            phrase("long-term"),
                                            phrase("goal-oriented"),
                                            phrase("innovat*"),
                                            phrase("persuad*"),
                                            phrase("founding"),
                                            phrase("willingness"),
                                            phrase("decisiveness"),
                                            phrase("toleran*"),
                                            phrase("curiosity"))))
s7$Competence <- "Entrepreneurship"
s7$SkillCode <- "S7"
s8 <- data.frame(kwic(Programs, pattern = c(phrase("strategic thinking"),
                                             phrase("controling"),
                                             phrase("plan"),
                                             phrase("planning"),
                                             phrase("strategy"),
                                             phrase("strategic"),
                                             phrase("control"),
                                             phrase("design"),
                                             phrase("designing"),
                                             phrase("balance"))))
s8$Competence <- "Strategic Thinking"
s8$SkillCode <- "S8"
s9 <- data.frame(kwic(Programs, pattern = c(phrase("negotiation"),
                                            phrase("selling"),
                                            phrase("procure"),
                                            phrase("promoting"),
                                            phrase("procurement"),
                                            phrase("sell"),
                                            phrase("sales"),
                                            phrase("buy"),
                                            phrase("buying"),
                                            phrase("purchase"),
                                            phrase("acquire"),
                                            phrase("consume"),
                                            phrase("contract"))))
s9$Competence <- "Negotiation"
s9$SkillCode <- "S9"
s10 <- data.frame(kwic(Programs, pattern = c(phrase("ethical thinking"),
                                             phrase("ethics"),
                                             phrase("moral"),
                                             phrase("morality"),
                                             phrase("honesty"),
                                             phrase("respect"),
                                             phrase("integrity"),
                                             phrase("ethicality"),
                                             phrase("honor"),
                                             phrase("responsible"),
                                             phrase("justice"),
                                             phrase("rectitude"))))
s10$Competence <- "Ethical Thinking"
s10$SkillCode <- "S10"
s11 <- data.frame(kwic(Programs, pattern = c(phrase("teamwork"),
                                             phrase("team worker"),
                                             phrase("team player"),
                                             phrase("work with others"),
                                             phrase("working with others"),
                                             phrase("team building"),
                                             phrase("team development"),
                                             phrase("meeting"),
                                             phrase("interact"),
                                             phrase("reunion"),
                                             phrase("assembly"),
                                             phrase("raising funds"))))
s11$Competence <- "Teamwork"
s11$SkillCode <- "S11"
s12 <- data.frame(kwic(Programs, pattern = c(phrase("analytical thinking"),
                                             phrase("analyzing"),
                                             phrase("analysis"),
                                             phrase("parse"),
                                             phrase("parser"),
                                             phrase("analyzer"),
                                             phrase("watch"),
                                             phrase("review"),
                                             phrase("evaluat*"),
                                             phrase("identify"),
                                             phrase("observ*"),
                                             phrase("notice"),
                                             phrase("perceiv*"),
                                             phrase("break down"),
                                             phrase("describe"),
                                             phrase("bring closer"),
                                             phrase("strengthen"),
                                             phrase("search"))))
s12$Competence <- "Analytical Thinking"
s12$SkillCode <- "S12"
s13 <- data.frame(kwic(Programs, pattern = c(phrase("decision making"),
                                             phrase("deci*"),
                                             phrase("decide"),
                                             phrase("making decisions"),
                                             phrase("judging"),
                                             phrase("selecting"),
                                             phrase("choose"),
                                             phrase("choos*"),
                                             phrase("choice"),
                                             phrase("selection"),
                                             phrase("determin*"))))
s13$Competence <- "Decision Making"
s13$SkillCode <- "S13"

df_list <- mget(paste0("s", 1:13))
SS <- do.call(rbind, df_list)
patrones <- data.frame(table(SS$pattern))
Patrones <- data.frame(table(SS$Competence))
SS <- merge(SS, Texts, by.x = "docname", by.y = "Text")
#rm(list=setdiff(ls(), "SS"))
save.image("Results/Result2.RData")
