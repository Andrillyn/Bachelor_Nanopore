#!/bin/bash
#SBATCH --partition normal
#SBATCH --mem-per-cpu 4G
#SBATCH -c 1
#SBATCH -t 0-01:00:00

infile=$1
predix=$2
genomesize=$3
outdir=$4

mkdir $outdir

canu-1.8/Linux-amd64/bin/canu -p $predix -d $outdir genomeSize=$genomesize -nanopore-raw $infile -corOutCoverage=999 -corMinCoverage=0 -minOverlapLength=400 -minReadLength=800