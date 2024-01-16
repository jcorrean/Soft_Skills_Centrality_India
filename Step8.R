load("Results/Result7.RData")
rm(list=setdiff(ls(), c("BachelorNetwork", "MastersNetwork", "PHDNetwork")))

BachelorNetwork$Level <- "Bachelor Program"
MastersNetwork$Level <- "Master Program"
PHDNetwork$Level <- "PhD Program"
