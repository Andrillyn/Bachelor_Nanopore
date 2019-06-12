#!/bin/bash

SECONDS=0
DATE=`date '+%Y%m%d%H%M'`
in=$1
OUT=$2/$DATE

mkdir -p $OUT

while squeue -u eriks | grep -q 'Sub_Pore'; do
    echo 'something is running'
    sleep 10
done

COUNTER=0
for path in $in/*fastq*
do
  mkdir -p $OUT/$COUNTER
	sbatch faststorage/scripts/Sub_Porechop_demultiplex.sh $path $OUT/$COUNTER
	COUNTER=$[$COUNTER +1]
  sleep 2
done

while squeue -u eriks | grep -q 'Sub_Pore'; do
    echo 'waiting up'
    sleep 10
done

'porechop_end='$SECONDS >> $OUT/$DATE_runtime.txt