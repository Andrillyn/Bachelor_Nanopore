#!/bin/bash
#SBATCH -p normal
#SBATCH -c 8
#SBATCH -t 0-02:00:00

in=$1
out=$2

source activate nanopore

minimap2 -x ava-ont -t8 $in $in | gzip -1 > $out