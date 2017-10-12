## Permutation test :

rm(list=ls())

library(readxl)
library(pROC)
library(ROCR)
library(xlsx)
library("gtools", lib.loc="~/R/win-library/3.3")

Hyper <- read_excel("C:/Users/pmo/Desktop/Hyper.xlsx")
Else <- read_excel("C:/Users/pmo/Desktop/Else.xlsx")


## PERMUTATION
All=rbind(Hyper,Else)
All[,16]=permute(All[,16])
Hyper=All[1:296,]
Else=All[297:649,]

Main_test=rbind(Hyper[1:59,],Else[1:71,])
Hyper=Hyper[50:296,]
Else=Else[72:353,]


## 5 fold cross validation -------------------------------------------------------

A=split(Hyper, rep(1:5))

B=split(Else, rep(1:5))


A1=A$`1`
A2=A$`2`
A3=A$`3`
A4=A$`4`
A5=A$`5`


B1=B$`1`
B2=B$`2`
B3=B$`3`
B4=B$`4`
B5=B$`5`


for (i in 1:5) {
  if (i==1) {
    Test=rbind(A1,B1)
    Train=rbind(A2,A3,A4,A5,B2,B3,B4,B5) 
  }  else if (i==2) {
    Test=rbind(A2,B2)
    Train=rbind(A1,A3,A4,A5,B1,B3,B4,B5)
  } else if (i==3) {
    Test=rbind(A3,B3)
    Train=rbind(A2,A1,A4,A5,B2,B1,B4,B5)
  } else if (i==4) {
    Test=rbind(A4,B4)
    Train=rbind(A2,A1,A3,A5,B2,B1,B3,B5)
  } else if (i==5) {
    Test=rbind(A5,B5)
    Train=rbind(A2,A1,A4,A3,B2,B1,B4,B3)
  }

  
  
  colnames(Train) <- c("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","GROUP")
  colnames(Test) <- c("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","GROUP")
  Train$GROUP=factor(Train$GROUP)
  
  m=glm(GROUP ~ A +B + C + D + E + F + G +H + I + J + K + L + M + O, data=Train,family = "quasibinomial")
  Pred = predict(m,Test) # We can use res instead of m if the result of the step function allows to get better results
  Prob = exp(Pred)/(1+exp(Pred))
  
  pred=prediction(Pred,Test[,16])
  auc.tmp <- performance(pred,"auc")
  auc <- as.numeric(auc.tmp@y.values)
  
  for (j in seq(0.001,0.999,0.001)){
    
    tmp = Prob>=j
    T=table(tmp,Test$GROUP)
    
    if (nrow(T) == 1 && rownames(T)=='FALSE') {
      Sp= 0
      Se= 0
      
    } else if ( nrow(T) == 1 && rownames(T)=='TRUE') {
      Sp= 1
      Se= 1
      
    } else {
      Sp= T[1,1]/(T[1,1]+T[2,1])
      Se= T[2,2]/(T[2,2]+T[1,2])
      Sp= 1-Sp 
    }
    
    if (j==0.001) {
      X = Sp
      Y = Se 
    } else {
      X=rbind(X,Sp)
      Y=rbind(Y,Se)
    }
    
  }
  
  X=t(X)
  Y=t(Y)
  
  if (i==1) {
    ROCx=X
    ROCy=Y
  } else {
    ROCx=rbind(ROCx,X)
    ROCy=rbind(ROCy,Y)
  }
  
  if (i==1) {
    AUC=auc
  } else {
    AUC=cbind(AUC,auc)
  }
  
}

rm(A1); rm(A2); rm(A3); rm(A4); rm(A5); rm(B1); rm(B2); rm(B3); rm(B4); rm(B5); rm(i); rm(Pred); rm(pred); rm(Prob); rm(T); rm(Se); rm(Sp); rm(tmp); rm(m); rm(j); rm(A); rm(B);

ROCxm=colMeans(ROCx, na.rm = FALSE, dims = 1)
ROCym=colMeans(ROCy, na.rm = FALSE, dims = 1)
AUCm=mean(AUC)
AUCmin=min(AUC)
AUCmax=max(AUC)

ROC=as.matrix(rbind(ROCxm,ROCym))


plot(ROCxm,ROCym,type="l", lwd=3, col="red", main='ROC curve for 5-fold Cross Validation with initial permutation', xlab="1-Specificity",ylab='Sensitivity')
lines(ROCx[1,],ROCy[1,],type="l",lty=2, col="grey")
lines(ROCx[2,],ROCy[2,],type="l", lty=2, col="grey")
lines(ROCx[3,],ROCy[3,],type="l", lty=2, col="grey")
lines(ROCx[4,],ROCy[4,],type="l", lty=2, col="grey")
lines(ROCx[5,],ROCy[5,],type="l", lty=2, col="grey")
text(0.7, 0.4, "AUC = 0.45 (0.40-0.49)", cex = 1)

#rm(ROCx); rm(ROCy); rm(X); rm(Y); rm(Test);rm(ROCxm); rm(ROCym)

## Model fitting -------------------------------------------------------

Main_train=rbind(Hyper,Else); rm(Train); rm(Else); rm(Hyper);

colnames(Main_train) <- c("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","GROUP")
colnames(Main_test) <- c("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","GROUP")
Main_train$GROUP=factor(Main_train$GROUP)

m=glm(GROUP ~ A +B + C + D + E + F + G +H + I + J + K + L + M + O, data=Main_train,family = "quasibinomial")

## Plot MODEL COEFFICIENTS

r=as.data.frame(m[1])
r=t(as.vector(r))
r=r[-1]
ss <- order(r, decreasing  = F)
r=r[ss]

z=c("CRP", "Albumin", "Glycosylated Hemoglobin",	"Glycemia",	"Total Cholesterol",	"HDL Cholesterol",	"LDL Cholesterol","Triglycerides",	"SBP",	"DBP",	"BMI",	"Gender, female",	"Age",	"MADRS total")
z=z[ss]
par(mar=c(6, 10, 4, 2) + 0.1)

library("colormap", lib.loc="~/R/win-library/3.3")
colo=colormap(colormap=colormaps$RdBu, nshades=15)

#CI=confint(m)
#ci.l= CI[,1]; ci.l=ci.l[-1]; ci.l=ci.l[ss]
#ci.u= CI[,2]; ci.u=ci.u[-1]; ci.u=ci.u[ss]


barplot2(r, main='Model coefficients for each Parameter', horiz=TRUE, xlab='Model Coefficients',xlim=c(-0.6, 0.8),  names.arg = z, las=1, cex.names=0.95, col=colo, plot.grid = TRUE) #plot.ci = TRUE, ci.l = ci.l, ci.u = ci.u,

#setwd("C:/Users/pmo/Desktop/Matlab files/Marqueurs/FOR R - 649/3 groups Stats/Single_model")
#write.xlsx(r, "Model.xlsx")

## Test the unique model on Main_test matrix

Pred = predict(m,Main_test) # We can use res instead of m if the result of the step function allows to get better results
Prob = exp(Pred)/(1+exp(Pred))

tmp = Prob>=0.5
T=table(tmp,Main_test$GROUP)
colnames(T)=c('Else','Hyper')
rownames(T)=c('Else','Hyper')
print(T)

Success= ((T[1,1]+T[2,2])/sum(T))*100
print('General :')
print(Success)
Success.Hyper=T[2,2]/sum(T[,2])*100
Success.Else=T[1,1]/sum(T[,1])*100
print('Hyper :')
print(Success.Hyper)
print('Else :')
print(Success.Else)





