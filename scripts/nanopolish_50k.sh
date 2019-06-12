#!/bin/bash
#SBATCH --partition normal
#SBATCH --mem-per-cpu 4G
#SBATCH -c 12
#SBATCH -t 0-02:00:00

#Took 1:14 for BC08

#Draft genome, in canu_assemblies
draft=$1
#rawreads, fast5
rawreads=$2
#sequencing_summary, in basecalled
sequencing_summary=$3
#demultiplexed reads, in guppy_demultiplex, fastq
trimmed_reads=$4
#Output directory
out=$5

conda activate nanopore

mkdir $out

#Indexing. It takes some time, but I havent found a way to make sure it remembers it.
nanopolish/nanopolish index -d $rawreads -s $sequencing_summary $trimmed_reads

minimap2/minimap2 -ax map-ont -t 8 $draft $trimmed_reads | samtools sort -o $out/reads.sorted.bam -T $out/reads.tmp
samtools index $out/reads.sorted.bam

sleep 5

#Polishing
python nanopolish/scripts/nanopolish_makerange.py $draft | parallel --results $out/nanopolish.results -P 4 \
    nanopolish/nanopolish variants --consensus -o $out/polished.{1}.vcf -w {1} -r $trimmed_reads -b $out/reads.sorted.bam -g $draft -t 4 --min-candidate-frequency 0.1


#gathering up
nanopolish/nanopolish vcf2fasta -g $draft $out/polished.*.vcf > $out/genome_polished.fa

echo "polish done"