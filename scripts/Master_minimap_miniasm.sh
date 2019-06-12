#!/bin/bash
#SBATCH -p normal
#SBATCH -c 1
#SBATCH -t 0-04:00:00

SECONDS=0
DATE=`date '+%Y%m%d%H%M'`
in=$1
out=$2

source activate nanopore

while squeue -u eriks | grep -q 'Mini'; do
    echo 'something is running'
    sleep 10
done

touch $out/reads.paf.gz
sbatch faststorage/scripts/Minimap_sub.sh $in $out/reads.paf.gz

while squeue -u eriks | grep -q 'Mini'; do
    echo 'waiting up on Minimap'
    sleep 30
done

sbatch faststorage/scripts/Miniasm_sub.sh $in $out/reads.paf.gz  $out/miniasm.reads.gfa 

while squeue -u eriks | grep -q 'Mini'; do
    echo 'waiting up on Miniasm'
    sleep 30
done

awk '/^S/{print ">"$2"\n"$3}' $out/miniasm.reads.gfa | fold > $out/miniasm.reads.fasta

'miniasm_end='$SECONDS > $out/$DATE_runtime.txt