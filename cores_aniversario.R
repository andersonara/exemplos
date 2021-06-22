require(foreach)
require(doParallel)

c1<-makeCluster(4)     #setando o numero de clusters a ser usado
registerDoParallel(c1) #configurando a condição foreach em paralelo

#exemplo do aniversário
#Pelo menos uma pessoa fazer aniversário no mesmo dia

paniversario<- function(n){
  k<-10000
  pop<-1:365
  algumaduplicada<-function(i)
    any(duplicated(
      sample(pop,n,replace=TRUE)))
  sum(sapply(seq(k),algumaduplicada))/k
}

#Tempo via paralelização
system.time( panivP<- foreach(n=1:100) %dopar% 
               paniversario(n) )

#Tempo sem paralelização
system.time( paniv<-sapply(1:100,paniversario) )

#Gráfico simples
plot(unlist(panivP),col='tomato',
     cex=0.5,ylab='prob',xlab='pessoas')
lines(unlist(paniv),col='gray',lwd=2)


