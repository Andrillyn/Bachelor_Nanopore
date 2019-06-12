#!/bin/bash
#SBATCH --partition normal
#SBATCH --mem-per-cpu 4G
#SBATCH -c 22
#SBATCH -t 1-17:00:00

ont-guppy-cpu/bin/guppy_basecaller -i faststorage/20181107_SingleBlind/fast5/ --recursive -s faststorage/2.3.5_basecalled/181107_SingleBlind/ --flowcell FLO-MIN106 --kit SQK-RPB004