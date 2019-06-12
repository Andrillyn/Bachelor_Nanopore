#!/bin/bash
#SBATCH -p normal
#SBATCH --mem-per-cpu 4G
#SBATCH -c 4
#SBATCH -t 0-04:00:00

in=$1
out=$2

source activate nanopore

porechop -i $1 -o $2 --discard_middle