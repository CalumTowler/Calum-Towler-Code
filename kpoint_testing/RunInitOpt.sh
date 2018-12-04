#!/bin/bash

# A script to submit multiple optimisations.

for (( i=$1; i<=$2; i++ ))
do 
	cd MP$i
	runvasp MP$i 24 2
	cd ..
done

echo Finished!
