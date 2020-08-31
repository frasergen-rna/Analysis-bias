# Analysis-bias
Identifying mapping bias

## bais.r
This scripts use a binomial distribution test to identify mapping bias

Usage:
`Rscript bais.r simulation.base.info.filt output.xls`

Required input are:
1. The information of parent snp



## ase_analysis.pl
Filtering out the SNP sites with < 95% parent1 and parent2 bases, and the total SNP depth < 10

Usage:
`perl ase_analysis.pl simulation.base.mrna_snp > output_file.xls`

Required input are:
1. SNP information corresponding to each gene

