#!/bin/bash
#SBATCH -p normal
#SBATCH -c 2
#SBATCH -t 0-02:00:00

in=$1

barcodes='BC01 BC02 BC03 BC04 BC05 BC06 BC07 BC08 BC09 BC10 BC11 BC12 BC12a none'

for barcode in $barcodes
do
  mkdir $1/$barcode
  cat $in/*/*$barcode* > $1/$barcode/merged$barcode.fastq
done

echo "Done with iterating"