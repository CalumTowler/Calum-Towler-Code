#!/bin/bash

#A script that deletes multiple jobs in the queue.

for (( i=$1; i<=$2; i++))
do
	qdel $i
done 
qstat
