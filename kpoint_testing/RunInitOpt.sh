#!/bin/bash

# A script to submit multiple optimisations.

for (( i=$1; i<=$2; i++ ))
do 
	cd MP$i
	runvasp MP$i 8 48
	cd ..
done

echo Finished!
