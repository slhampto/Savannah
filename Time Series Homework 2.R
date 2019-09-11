library(haven)
library(fma)
library(tseries)
library(expsmooth)
library(lmtest)
library(zoo)
install.packages("fma")
library(fma)
setwd("~/Master of Science in Analytics/Times Series")
aggregatedfile<-read.csv("aggregatedfile.csv")

evenmorenew<-aggregatedfile[,-c(1,3:4)]
evenmorenew

avergeaggregation<-ts(evenmorenew,start=2014,end=2019,frequency = 12)
decomp_stl<-stl(avergeaggregation,s.window = 7)
plot(decomp_stl)

trainset<-data.frame(aggregatedfile[1:54,])
trainset
trainset<-trainset[,-c(1,3:4)]
trainset
testset<-data.frame(aggregatedfile[55:60,])
testset<-testset[,-c(1,3:4)]
testset
testobject<-ts(testset,start=2014,frequency = 6)
testobject
single<-ses(testobject,initial="optimal",h=6)
summary(single)

firstholt<-holt(testobject,initial = "optimal",h=6)
summary(firstholt)

damped<-holt(testobject,initial = "optimal",h=6,damped = TRUE)
summary(damped)

seasonaladditive<-hw(testobject,seasonal = "additive")