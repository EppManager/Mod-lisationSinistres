#----------------------------------------------Read and prepare Data-------------------------------------------------------

montant=read.csv("montantssinistre.csv",sep=";",dec=",")
montant$X=NULL
str(montant)

nombres=read.csv("nombresinistre.csv",sep=";",dec=",")
nombres$X=NULL
str(nombres)

SinistreData=cbind(montant,nombres)
str(SinistreData)
names(SinistreData)[1]="montant"
names(SinistreData)[2]="nombres"
str(SinistreData)

write.csv(SinistreData,"SinistreData.csv")
#------------------------------------------Histogramme-------------------------------------------------------
SinistreData=read.csv("SinistreData.csv",sep=";",dec=",")
str(data)
table(SinistreData$montant)
table(SinistreData$nombres)
SinistreData$nombres[1]
SinistreData$montant[1]
plot(table(SinistreData$nombres))
plot(table(SinistreData$montant))
#------------------------------------------Modelisation-------------------------------------------------------
install.packages("fitdistrplus")
library(fitdistrplus)

                    # I. SinistreData$nombres
# (1)  fit of a poisson distribution
fitp <- fitdist(SinistreData$nombres,"pois")
summary(fitp)
plot(fitp)
cdfcomp(fitp, addlegend=FALSE)
ppcomp(fitp, addlegend=FALSE)
qqcomp(fitp, addlegend=FALSE)

# (2) fit of a negative binomial distribution
fitnb <- fitdist(SinistreData$nombres,"nbinom")
summary(fitnb)
plot(fitnb)
cdfcomp(fitnb, addlegend=FALSE)
ppcomp(fitnb, addlegend=FALSE)
qqcomp(fitnb, addlegend=FALSE)

# (3) fit of a  binomial distribution
fitBi=fitdist(SinistreData$nombres, dist="binom", fix.arg=list(size=11), start=list(prob=0.3))
summary(fitBi)
plot(fitBi)
cdfcomp(fitBi, addlegend=FALSE)
ppcomp(fitBi, addlegend=FALSE)
qqcomp(fitBi, addlegend=FALSE)
# (4) Comparison of various fits #cumulative distribution function
cdfcomp(list(fitp,fitnb,fitBi), legendtext=c("poisson", "negative binomial", " binomial"))
gofstat(list(fitp,fitnb,fitBi))

                    # II. SinistreData$nombres
# (1) fit of a gamma distribution by maximum likelihood estimation
fitg <- fitdist(SinistreData$montant, "gamma")
summary(fitg)
plot(fitg, histo = FALSE, demp = TRUE)
cdfcomp(fitg, addlegend=FALSE)
denscomp(fitg, addlegend=FALSE)
ppcomp(fitg, addlegend=FALSE)
qqcomp(fitg, addlegend=FALSE)

# (2) fit of a lognormal distribution by maximum likelihood estimation
fitln <- fitdist(SinistreData$montant, "lnorm")
summary(fitln)
plot(fitln, histo = FALSE, demp = TRUE)
cdfcomp(fitln, addlegend=FALSE)
denscomp(fitln, addlegend=FALSE)
ppcomp(fitln, addlegend=FALSE)
qqcomp(fitln, addlegend=FALSE)

# (3) fit of a weibull distribution by maximum likelihood estimation
fitW <- fitdist(SinistreData$montant, "weibull")
summary(fitW)
plot(fitW, histo = FALSE, demp = TRUE)
cdfcomp(fitW, addlegend=FALSE)
denscomp(fitW, addlegend=FALSE)
ppcomp(fitW, addlegend=FALSE)
qqcomp(fitW, addlegend=FALSE)

# (4) fit of a normal distribution by maximum likelihood estimation
fitn <- fitdist(SinistreData$montant, "norm")
summary(fitn)
plot(fitn, histo = FALSE, demp = TRUE)
cdfcomp(fitn, addlegend=FALSE)
denscomp(fitn, addlegend=FALSE)
ppcomp(fitn, addlegend=FALSE)
qqcomp(fitn, addlegend=FALSE)

# (5) Comparison of various fits
cdfcomp(list(fitW, fitg, fitln, fitn), legendtext=c("Weibull", "gamma", "lognormal", "normal"))
denscomp(list(fitW, fitg, fitln,fitn), legendtext=c("Weibull", "gamma", "lognormal", "normal"))
qqcomp(list(fitW, fitg, fitln, fitn), legendtext=c("Weibull", "gamma", "lognormal", "normal"))
ppcomp(list(fitW, fitg, fitln, fitn), legendtext=c("Weibull", "gamma", "lognormal", "normal"))
gofstat(list(fitW, fitg, fitln, fitn), fitnames=c("Weibull", "gamma", "lognormal", "normal"))







