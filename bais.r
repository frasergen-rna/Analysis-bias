args <- commandArgs(TRUE)
n <- read.table(args[1])
n3 <- n[[3]]
n5 <- n[[5]]
n6 <- n[[6]]
colnames(n) <- c('chr*site','parent1-snp','parent1-dep','parent2-snp','parent2-dep','total-dep')
pvalue <- vector(length=length(n3))
for (i in 1:length(n3)){pvalue[i]=binom.test(n3[i],n6[i],(1/2),alternative="greater")$p.value}
n7 <- log2(n[[3]]/n[[5]])
log2FC <- vector(length=length(n3))
for (i in 1:length(n3)){log2FC[i]=n7[i]}
value <- cbind (n,log2FC,pvalue)
write.table(value,file=args[2],append=FALSE,quote=FALSE,row.names=FALSE)

