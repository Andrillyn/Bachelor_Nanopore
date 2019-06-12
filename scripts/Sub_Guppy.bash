#!/bin/bash
#SBATCH --partition normal
#SBATCH --mem-per-cpu 4G
#SBATCH -c 2
#SBATCH -t 0-02:00:00

in=$1
out=$2

ont-guppy-cpu/bin/guppy_basecaller -i $in -s $out --flowcell FLO-MIN106 --kit SQK-RPB004