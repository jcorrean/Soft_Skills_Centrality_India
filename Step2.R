load("Results/Result1.RData")
library(quanteda)
s1 <- data.frame(kwic(Programs, pattern = c(phrase("critical thinking"), 
                                            phrase("think critically"), 
                                            phrase("criticism"),
                                            phrase("understand*"),
                                            phrase("think"), 
                                            phrase("reasoning"))))
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
s3 <- data.frame(kwic(Programs, pattern = c(phrase("communication"),
                                            pgrase("communicat*"),
                                            phrase("talk*"),
                                            phrase("speak*"),
                                            phrase("listen*"),
                                            phrase("argu*"),
                                            phrase("writ*"))))
s4 <- data.frame(kwic(Programs, pattern = c(phrase("create"),
                                            phrase("creativity"),
                                            phrase("generate"),
                                            phrase("produce"),
                                            phrase("creation"),
                                            phrase("conceive"),
                                            phrase("propose"))))
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
                                            phrase("manag*"))))
s7 <- data.frame(kwic(Programs, pattern = c(phrase("entrepreneurship"),
                                            phrase("entrepreneur"),
                                            phrase("nudg*"),
                                            phrase("manifest"),
                                            phrase("")
                                            phrase("undertake"),
                                            phrase("coopera*"),
                                            phrase("adaptability"),
                                            phrase("curiosity"),
                                            phrase("curiousness"),
                                            phrase("long-term"),
                                            phrase("goal-oriented"),
                                            phrase("innovate"),
                                            phrase("persuad*"),
                                            phrase("founding"),
                                            phrase("push"),
                                            phrase("willingness"),
                                            phrase("decisiveness"),
                                            phrase("toleran*"),
                                            phrase("curiosity"))))
s8 <- data.frame(kwic(Programs, pattern = c(phrase("control"),
                                             phrase("controling"),
                                             phrase("plan"),
                                             phrase("planning"),
                                             phrase("strategy"),
                                             phrase("strategic"),
                                             phrase("strategic thinking"),
                                             phrase("design"),
                                             phrase("designing"),
                                             phrase("balance"))))
s9 <- data.frame(kwic(Programs, pattern = c(phrase("negotiation"),
                                            phrase("selling"),
                                            phrase("procure"),
                                            phrase("procurement"),
                                            phrase("sell"),
                                            phrase("sales"),
                                            phrase("buy"),
                                            phrase("purchase"),
                                            phrase("consume"),
                                            phrase("contract"))))
s10 <- data.frame(kwic(Programs, pattern = c(phrase("ethical thinking"),
                                             phrase("ethics"),
                                             phrase("moral"),
                                             phrase("morality"),
                                             phrase("honesty"),
                                             phrase("integrity"),
                                             phrase("ethicality"),
                                             prhase("honor"),
                                             phrase("responsible"),
                                             phrase("justice"),
                                             phrase("rectitude"))))
s11 <- data.frame(kwic(Programs, pattern = "conflict"))

s18 <- data.frame(kwic(Programs, pattern = "understand"))
s19 <- data.frame(kwic(Programs, pattern = "teamwork"))
s20 <- data.frame(kwic(Programs, pattern = "planning"))
s21 <- data.frame(kwic(Programs, pattern = "generate"))
s22 <- data.frame(kwic(Programs, pattern = "empathy"))
s23 <- data.frame(kwic(Programs, pattern = "share"))
s24 <- data.frame(kwic(Programs, pattern = "analyze"))
s25 <- data.frame(kwic(Programs, pattern = "acknowledge"))
s26 <- data.frame(kwic(Programs, pattern = "guide"))
s27 <- data.frame(kwic(Programs, pattern = "respect"))
s28 <- data.frame(kwic(Programs, pattern = "motivat*"))
s29 <- data.frame(kwic(Programs, pattern = "cooperat*"))
s30 <- data.frame(kwic(Programs, pattern = "strengthen"))
s31 <- data.frame(kwic(Programs, pattern = "thrust"))
s32 <- data.frame(kwic(Programs, pattern = phrase("bring closer")))
s33 <- data.frame(kwic(Programs, pattern = "bridge"))
s34 <- data.frame(kwic(Programs, pattern = "change"))
s35 <- data.frame(kwic(Programs, pattern = "appreciate"))
s36 <- data.frame(kwic(Programs, pattern = "foment"))
s37 <- data.frame(kwic(Programs, pattern = "interact"))
s38 <- data.frame(kwic(Programs, pattern = "identify"))
s39 <- data.frame(kwic(Programs, pattern = "compete"))
s42 <- data.frame(kwic(Programs, pattern = "evaluat*"))

s44 <- data.frame(kwic(Programs, pattern = "deci*"))


df_list <- mget(paste0("s", 1:50))
SS <- do.call(rbind, df_list)
rm(list=setdiff(ls(), "SS"))
save.image("Results/Result2.RData")
