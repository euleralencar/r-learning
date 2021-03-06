x <- list(a=1:5, b=rnorm(10))

lapply(x,mean)

x <- matrix(c(1,2,3,4),2,2)

x <- 1:4
lapply(x,runif)

i39 <- sapply(3:9, seq)
sapply(i39, fivenum)

x <- list(a=matrix(1:4,2,2), b= matrix(1:6,3,2))

lapply(x,function(elt) elt[,1])

x <- list(a=1:4, b=rnorm(10), c=rnorm(20,1), d=rnorm(100,5))
lapply(x,mean)
sapply(x,mean) # return like matrix
tapply(x,mean)
rapply(x,mean)

## Apply Function

str(apply)

x <- matrix(rnorm(200),20,10)
apply(x,2,mean) # Aplico a m�dia das colunas
apply(x,1,sum) # Aplico a m�dia das linhas

apply(x,2,quantile, probs= c(0.25,0.75))

a <- array(rnorm(2*2*10),c(2,2,10))
apply(a,c(1,2), mean)
rowMeans(a,dims=2)
?rowMeans

x <- cbind(x1=3, x2=c(4:1, 2:5))
rowSums(x)
colSums(x)

# Minhas anota��es
notas <- c(65,64,70,66,63,65,61,64,66,55)
m_notas <- mean(notas)
m_notas
des_notas <- sd(notas)
des_notas
x1 <- seq(-5,5,0.01)
plot(dnorm(x1,mean=0,sd=1), type="l")
#rnorm(100, mean=m_notas, sd=des_notas))


tabela <- data.frame()
tabela <- table()

#opcao1
ambiente <- c("Lagoa_Aberta","Lagoa_Aberta","Lagoa_Fechada","Lagoa_Fechada","Canal","Canal")
abundancia <- c(13,11,9,6,17,15)
tabela <- data.frame(ambiente,abundancia)
tabela
#opcao2
tabela2 <- data.frame(ambiente=c("Lagoa_Aberta","Lagoa_Aberta","Lagoa_Fechada","Lagoa_Fechada","Canal","Canal"),
                     abundancia=c(13,11,9,6,17,15))

#dados
x1 <- "Lagoa_Aberta"
x2 <- c(13, 11, 14, 12, 12, 10, 10, 15, 10, 13, 11, 12, 11, 10, 14)
x3 <- "Lagoa_Fechada"
x4 <- c(9, 6, 9, 5, 8, 10, 11, 11, 5, 8, 5, 11, 11, 8, 6)
x5 <- "Canal"
x6 <- c(17, 15, 20, 19, 17, 23, 21, 18, 19, 21, 15, 15, 19, 15, 17)

l1 <- data.frame(x1,x2)
l2 <- data.frame(x3,x4)
l3 <- data.frame(x5,x6)
colnames(l1) = c("ambiente","abundancia")
colnames(l2) = c("ambiente","abundancia")
colnames(l3) = c("ambiente","abundancia")

tabela <- rbind(l1,l2,l3)
head(tabela)
#colnames(tabela)=c("ambiente","abundancia")
#tabela$abundancia <- as.numeric(tabela$abundancia)
tabela


tabela2 <- cbind(tabela,col)

head(tabela2)
mean(tabela2$abundancia)


#Eu poderia utilizar a fun��o gl
tabela <- data.frame(ambiente=gl(3,15,labels=c("Lagoa_Aberta","Lagoa_Fechada","Canal")),
                     abundancia=c(x2,x4,x6))

#mean(tabela$abundancia)

#####
# r1 <- data.frame(cbind(x2,x4,x6))
# r1
# colnames(r1)=c(x1,x3,x5)
# r1
# anova <- aov()
#####

anova <- aov(abundancia~ambiente,data=tabela)
#anova2 <- lm(abundancia~ambiente,data=tabela)
anova
#anova2
summary(anova)
#summary(anova2)
shapiro.test(resid(anova))
qqnorm(resid(anova)); qqline(resid(anova),col=2)

library(car)
leveneTest(abundancia~ambiente,data=tabela) # Teste de homogeneidade das vari�veis
TukeyHSD(anova) #Teste de Tukey para verificar quais pares mostram-se diferentes
plot(TukeyHSD(anova,ordered=T))
boxplot(abundancia~ambiente,data=tabela, col="lightblue", main="Teste Anova")

anova_com_lm <- lm(abundancia~ambiente,data=tabela)
summary(anova_com_lm)
shapiro.test(resid(anova_com_lm))
qqnorm(resid(anova_com_lm)); qqline(resid(anova_com_lm),col=2)

leveneTest(abundancia~ambiente,data=tabela) # Teste de homogeneidade das vari�veis
# N�o � aplicado para lm: TukeyHSD(anova_com_lm) #Teste de Tukey para verificar quais pares mostram-se diferentes
#plot(TukeyHSD(anova_com_lm,ordered=T))
boxplot(abundancia~ambiente,data=tabela, col="lightblue", main="Teste Anova")

###########################
# Outro exemplo R-project
##########################

chocolate <- data.frame(
  Sabor =
    c(5, 7, 3,
      4, 2, 6,
      5, 3, 6,
      5, 6, 0,
      7, 4, 0,
      7, 7, 0,
      6, 6, 0,
      4, 6, 1,
      6, 4, 0,
      7, 7, 0,
      2, 4, 0,
      5, 7, 4,
      7, 5, 0,
      4, 5, 0,
      6, 6, 3
    ),
  Tipo = factor(rep(c("A","B","C"),15)),
  Provador = factor(rep(1:15, rep(3,15))))

tapply(chocolate$Sabor, chocolate$Tipo, mean) # Aplica m�dia para o saber em cada Tipo
ajuste <- lm(chocolate$Sabor ~ chocolate$Tipo + chocolate$Provador)
summary(ajuste)
anova(ajuste)

a1 <- aov(chocolate$Sabor ~ chocolate$Tipo + chocolate$Provador)
posthoc <- TukeyHSD(x=a1, 'chocolate$Tipo', conf.level=0.95)
plot(TukeyHSD(x=a1,'chocolate$Tipo', ordered=T))

summary(a1)
plot(a1)
#plot(rstudent(a1)~a1$fitted)

library(agricolae)
b <- HSD.test(ajuste, 'chocolate$Tipo', console=TRUE) # group=T)

# a <- rep(1:15,rep(1:15))

#Another example

library(agricolae)
data(sweetpotato)
model<-aov(yield~virus, data=sweetpotato)
out <- HSD.test(model,"virus", group=TRUE,console=TRUE,
                main="Yield of sweetpotato\nDealt with different virus")
#stargraph
bar.group(out$groups,ylim=c(0,45),density=4,border="blue")
#endgraph
out<-HSD.test(model,"virus", group=FALSE)
means<-out$means

# Old version HSD.test()
attach(sweetpotato)
df<-df.residual(model)
MSerror<-deviance(model)/df
HSD.test(yield,virus,df,MSerror, group=TRUE,console=TRUE,
         main="Yield of sweetpotato. Dealt with different virus")
detach(sweetpotato)

# fonte: http://www.inside-r.org/packages/cran/agricolae/docs/HSD.test

#####################################################

data1 <- data.frame(id=1:50, var="fulano")
data2 <- data.frame(id=45:100, var2="ciclano")

head(data1)
head(data2)

data3 <- merge(data1,data2,by="id") #procv para r
data3

authors <- data.frame(
  name = I(c("Tukey", "Venables", "Tierney", "Ripley", "McNeil")),
  nationality = c("US", "Australia", "US", "UK", "Australia"),
  deceased = c("yes", rep("no", 4)))
books <- data.frame(
  name = I(c("Tukey", "Venables", "Tierney",
             "Ripley", "Ripley", "McNeil", "R Core")),
  title = c("Exploratory Data Analysis",
            "Modern Applied Statistics ...",
            "LISP-STAT",
            "Spatial Statistics", "Stochastic Simulation",
            "Interactive Data Analysis",
            "An Introduction to R"),
  other.author = c(NA, "Ripley", NA, NA, NA, NA,
                   "Venables & Smith"))

# Quando quero relacionar vari�veis com nomes diferentes
(m1 <- merge(authors, books, by.x = "surname", by.y = "name")) 
(m2 <- merge(books, authors, by.x = "name", by.y = "surname"))
(m3 <- merge(authors, books, by="name")) # As duas tabelas precisam ter o mesmo nome de vari�vel de merge

books <- books[-1,]
books <- books[-3,]
rownames(books) = 1:5

help(bptest)

# Importando dados
setwd()
install.packages("XLConnect")
library(XLConnect)

dados <- readWorkSheetFromFile("Caminho", startRow="linhadecomeco", head=T, sheet=1)





