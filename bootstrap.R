# Bootstrap 95% CI para o R-Quadrado
library(boot)

# Fun��o para obter o R-Quadraro a partir de uma base de dados
rsq <- function(formula, data, indices)
{
  d <- data[indices,] # permite boot para selecionar amostra
  fit <- lm(formula, data=d)
  return(summary(fit)$r.square)
}

# bootstrapping com 1000 repeti��es
results <- boot(data=mtcars, statistic=rsq, R=1000, formula=mpg~wt+disp)

# Apresenta os Resultados
results
plot(results)

# intervalo de confian�a de 95%
boot.ci(results)
#names(results)


#________________
# outra metodologia
#_________________

0 - ppois(0,lambda=2)
0.3 - ppois(1,lambda=2)
0.6 - ppois(2,lambda=2)
0.7 - ppois(3,lambda=2)
0.9 - ppois(4,lambda=2)
1 - (ppois(100,lambda=2) - ppois(4,lambda=2))

### Exemplo BootStrap ####
library(bootstrap)
data(law)

#Estimativa Bootstrap do vi�s do coef. Correla��o R
theta.hat <- cor(law$LSAT, law$GPA)

#Estimativa bootstrap do vi�s
B <- 2000 #N�mero de r�plicas
n <- nrow(law)
theta.b <- numeric(B)
  for (b in 1:B) {
      i <- sample(1:n, size = n, replace=TRUE) # i � o vetor dos �ndices
      LSAT <- law$LSAT[i]
      GPA <- law$GPA[i]
      theta.b[b] <- cor(LSAT,GPA)
  }
bias <- mean(theta.b) - theta.hat
bias

#________________________
#
#________________________












