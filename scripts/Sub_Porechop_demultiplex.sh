#!/bin/bash
#SBATCH -p normal
#SBATCH -c 2
#SBATCH -t 0-01:00:00

in=$1
out=$2

source activate nanopore

porechop -i $1 -b $2