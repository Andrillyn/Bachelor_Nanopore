#!/bin/bash
#SBATCH -p normal
#SBATCH -c 4
#SBATCH -t 0-01:00:00

in=$1
map=$2
out=$3

miniasm/miniasm -f $in $map > $out