#!/bin/bash
#SBATCH -p normal
#SBATCH -c 2

in=$1
BC=$2

COUNTER=0

for files in $in/*/* 
do
  if [[ $files == *$BC* ]]
  then
    echo "found"
    echo $COUNTER
    (( COUNTER ++ ))
  fi
done

echo "Done with iterating"