#!/bin/bash
#SBATCH --partition normal
#SBATCH --mem-per-cpu 4G
#SBATCH -c 22
#SBATCH -t 2-12:00:00

ont-guppy-cpu/bin/guppy_basecaller -i faststorage/20181012_Firstbarcodes/fast5/ --recursive -s faststorage/2.3.5_basecalled/181012_Firstbarcodes/ --flowcell FLO-MIN106 --kit SQK-RPB004