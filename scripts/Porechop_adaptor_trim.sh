#!/bin/bash
#SBATCH -p normal
#SBATCH -c 1
#SBATCH -t 0-06:00:00

SECONDS=0
DATE=`date '+%Y%m%d%H%M'`
in=$1

while squeue -u eriks | grep -q 'Sub_Pore'; do
    echo 'something is running'
    sleep 10
done

COUNTER=0
for path in $in/*/*fastq_runid*
do
  COUNTER=$[$COUNTER +1]
  barfolder=${path%/*}
  touch $barfolder/${COUNTER}_trimmed.fastq
  sbatch faststorage/scripts/Sub_Porechop_trim.sh $path $barfolder/${COUNTER}_trimmed.fastq
  sleep 60
done

while squeue -u eriks | grep -q 'Sub_Pore'; do
    echo 'waiting up'
    sleep 10
done
echo trimmed $COUNTER files
