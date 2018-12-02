#!/bin/bash

#A script to resubmit multiple FixedCell optimisations.

for (( i=$1; i<=$2; i++ ))
do
	cd MP$1/FixedCell/
	qsub f_MP$1.script
	cd ../..
	echo Submitted MP$1
done




