#!/bin/bash
# Basic for loop
ref=$1
aln=$2
source /com/extra/GATK/3.8/load.sh
   java -jar /com/extra/GATK/3.8/jar-bin/GenomeAnalysisTK.jar \
     -R $ref \
     -T HaplotypeCaller \
     -I $aln\
     --emitRefConfidence BP_RESOLUTION \
     -stand_call_conf 0 \
     -o output.more.snps.g.vcf