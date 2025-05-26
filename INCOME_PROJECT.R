rm(list = ls(all.names = T))
#----------------------------------------
## Cleaning The income
Income = read.csv(file.choose())
View(Income)
anyNA(Income)
boxplot(Income)$out
summary(Income)
------------------------------------
Income
attach(Income)
Y
anyNA(Y)
mean(Y,na.rm = T)
summary(Y)
#---------------------------------------------
library("Hmisc")
c = impute(Y,median)
c
summary(c)
boxplot(c)$out
anyNA(c)
#---------------------------------------------

lower=median(c)-1.5* IQR(c);lower
upper=median(c)+1.5* IQR(c);upper
c1 = c
c1[c>upper]=NA
c1[c<lower]=NA
c1
summary(c1)
boxplot(c1)$out
c2 <- impute(c1,median)
c2
summary(c2)
boxplot(c2)$out
#--------------------------------------
write.csv(c2,"new_income.csv")
