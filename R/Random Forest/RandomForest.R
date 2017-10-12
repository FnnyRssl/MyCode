## RANDOM FOREST 

library(randomForest)
library(readxl)
library(party)

Hyper <- read_excel("C:/Users/pmo/Desktop/Hyper.xlsx")
Else <- read_excel("C:/Users/pmo/Desktop/Else.xlsx")

Data=rbind(Hyper,Else)

colnames(Data) <- c("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","GROUP")

Data$GROUP=factor(Data$GROUP)

output.forest=randomForest(GROUP ~ A +B + C + D + E + F + G +H + I + J + K + L + M + O, data=Data, ntree=10000)

# View the forest results.
print(output.forest) 

# Importance of each predictor.
Predictors=(output.forest$importance) 
rownames(Predictors)=c("CRP", "Albumin", "Glycosylated Hemoglobin",	"Glycemia",	"Total Cholesterol",	"HDL Cholesterol",	"LDL Cholesterol","Triglycerides",	"SBP",	"DBP",	"BMI",	"Gender, female",	"Age",	"MADRS total")
print(Predictors)

library("colormap", lib.loc="~/R/win-library/3.3")
colo=colormap(colormap=colormaps$RdBu, nshades=14)

Predictors=t(Predictors)
ss <- order(Predictors, decreasing  = F)
Predictors=Predictors[ss]

z=c("CRP", "Albumin", "Glycosylated Hemoglobin",	"Glycemia",	"Total Cholesterol",	"HDL Cholesterol",	"LDL Cholesterol","Triglycerides",	"SBP",	"DBP",	"BMI",	"Gender, female",	"Age",	"MADRS total")
z=z[ss]


par(mar=c(6, 10, 4, 2) + 0.1)
barplot2(Predictors,main='Random forest parameters weighting',horiz=TRUE,names.arg = z, las=1, cex.names=0.95, col=colo, plot.grid = TRUE) #, , horiz=TRUE, xlab='Model Coefficients',xlim=c(-0.6, 0.8),  names.arg = z, las=1, cex.names=0.95, col=colo, plot.grid = TRUE) #plot.ci = TRUE, ci.l = ci.l, ci.u = ci.u,


## Random Forest Cross-Validation for feature selection (function rfcv of randomForest package)

rownames(output.forest$"importance")=c("CRP", "Albumin", "Glycosylated Hemoglobin",	"Glycemia",	"Total Cholesterol",	"HDL Cholesterol",	"LDL Cholesterol","Triglycerides",	"SBP",	"DBP",	"BMI",	"Gender, female",	"Age",	"MADRS total")
#varImpPlot(output.forest, sort=TRUE)
