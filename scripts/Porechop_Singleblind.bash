#!/bin/bash
#SBATCH --partition normal
#SBATCH --mem-per-cpu 4G
#SBATCH -c 34
#SBATCH -t 0-10:00:00

porechop -i faststorage/v2_basecalled/181107_SingleBlind/ -b faststorage/porechopped/181107_SingleBlind/