
rm(list=ls())
library("ROCR", lib.loc="~/R/win-library/3.3")
require(MASS) # load Package

# Import the file 

library(readxl)
Data <- read_excel("C:/Users/pmo/Desktop/649_for_R.xlsx")

# Give names to the columns

colnames(Data) <- c("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","GROUP")

# Factorize the last (reponse) colunm 

head(Data,1); Data$GROUP=factor(Data$GROUP)

# Select random patients for Base and Test

ind = sample(1:nrow(Data),500) # random raw numbers = the number of patients on which we will build the model
Data2 = Data[ind,]
Test = Data[-ind,] # We remove the selected patients to get our Test matrix
#rm(Data)
#rm(Hyper_v_Else)

# Run the multinomial logistic regression

m=glm(GROUP ~ A +B + C + D + E + F + G +H + I + J + K + L + M + N + O, data=Data2,family = "quasibinomial")
#res = step(m,direction='both') # select the more relevant markers
Pred = predict(m,Test) # We can use res instead of m if the result of the step function allows to get better results
prob = exp(Pred)/(1+exp(Pred))
tmp = prob>=0.5
T=table(tmp,Test$GROUP)
colnames(T) <- c('Else', 'Hyper')
score = diag(T)/rowSums(T)
#colnames(score) <- c('Else', 'Hyper')


pred=prediction(Pred,Test[,16])
perf <- performance(pred, "tpr", "fpr")
perf.auc = performance(pred,'auc')
perf.auc.areas = slot(perf.auc,'y.values')
curve.areas= mean(unlist(perf.auc.areas))
auc =perf.auc@y.values
auc=as.numeric(auc)

# Plotting
plot(perf,main=paste("ROC for Classification by Logistic Regression","\n ", 'Area under the Curve =', auc))


# Print

print(T)
print('Prediction accuracy (in %)')
print(score)
print('Mean prediction accuracy')
print(mean(diag(T)/rowSums(T)))

Stats <- exp(cbind(OR = coef(m), confint(m)))

#res=res/30
#print('RES =')
#print(res)