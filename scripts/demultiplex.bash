#!/bin/bash
#SBATCH --partition normal
#SBATCH --mem-per-cpu 4G
#SBATCH -c 22
#SBATCH -t 0-14:00:00

in=$1
OUT=$2

ont-guppy-cpu/bin/guppy_barcoder -i $in -s $OUT --recursive -q 0 --flowcell FLO-MIN106 --kit SQK-RPB004