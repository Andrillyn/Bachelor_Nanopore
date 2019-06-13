#First part of the code taken from https://palfalvi.org/post/local-blast-from-r/ and then modified
#Overview of output possibilities http://www.metagenomics.wiki/tools/blast/blastn-output-format-6 

install.packages("tidyverse")
install.packages("ggplot2")
install.packages("Rcpp")
install.packages("colorspace")
install.packages("rlang")
.libPaths()
library(tidyverse)
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("Biostrings", version = "3.8")
library(ggplot2)
library(dplyr)
library(tidyverse)


setwd("C:/Users/Erik/Desktop/GenomeDK/Rstudio")
blastn = "C:/Program Files/NCBI/blast-2.8.1+/bin"


manual_input = "C:/Users/Erik/Desktop/GenomeDK/Resistance_Genes/BlaZ.fasta"
evalue = 1
format = ' "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send sseq evalue bitscore qcovs" ' 
identity_percent = 20
colnames <- c("qseqid",
              "sseqid",
              "pident",
              "length",
              "mismatch",
              "gapopen",
              "qstart",
              "qend",
              "sstart",
              "send",
              "sseq",
              "evalue",
              "bitscore",
              "qcovs")

gene_list = list.files(path = "C:/Users/Erik/Desktop/GenomeDK/Resistance_Genes/", full.names = TRUE)
for (file in input_list){
  print(file)
  print(basename(file))
}
blast_func <- function(input, db) {
  blast_out <- system2(command = "blastn", 
                     args = c("-db", db, 
                              "-query", input, 
                              "-outfmt", format, 
                              "-evalue", evalue,
                              "-perc_identity", identity_percent),
                     stdout = TRUE) %>%
    enframe(name = NULL) %>% 
    separate(col = value, 
              into = colnames,
              sep = "\t",
              convert = TRUE)
}
result <- blast_func(manual_input, blast_db)

output_tib <- tibble(Contig = character(), Gene = character(), pident = character(), qcov = character())

genome_search <- function(blast_db){
for (input in gene_list){
  temp_blast <- blast_func(input, blast_db)
  if (is.na(temp_blast[1,1])){
  } else {
    val = temp_blast[[1, 14]]
    if (val >= 20){
      output_tib <- add_row(output_tib, Contig = temp_blast[[1, 2]],Gene = basename(input), pident = temp_blast[[1, 3]], qcov = temp_blast[[1, 14]])
      }
    }
  }
return(output_tib)
}
gene_list = list.files(path = "C:/Users/Erik/Desktop/GenomeDK/Resistance_Genes/", full.names = TRUE)
blast_db = "C:/Users/Erik/Desktop/GenomeDK/Blast_Database/BigBlind_BC07.fasta"
genome_results <- genome_search(blast_db)
print(genome_results)

library(readxl)
epi2me_results <- read_excel("Results_Epi2Me_comp.xlsx")
sum(epi2me_results$`Pident in assembly` > 0)
sum(epi2me_results$`Location in assembly` == "Not found")

independence_testing <- read_excel("Independence.xlsx")
cor.test(independence_testing$`Nanodrop 280/260`, y=independence_testing$`ng/ul`, method = "pearson")

resistance_testing <- read_excel("Resistance_stats.xlsx")
cor.test(resistance_testing$`Accuracy in Epi2Me...7`, y=resistance_testing$`Pident*coverage`)
cor.test(resistance_testing$Statistic, y=resistance_testing$`Pident*coverage`)
resistance_testing_mut <- mutate(resistance_testing, Gene_present = if_else(resistance_testing$`Pident*coverage` > 20, 1, 0))
resistance_testing_mut <- mutate(resistance_testing_mut, Epi_10 = if_else(resistance_testing_mut$Statistic > 20, 1, 0))
chisq.test(resistance_testing_mut$Gene_present, y=resistance_testing_mut$Epi_10)
