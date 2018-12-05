#!/bin/bash

# A script that loops through the directories, searches for the cell volume in the OUTCAR and writes it to a file called CellVol.txt

for (( i=$1; i<=$2; i++ ))
do
	cd MP$i
	grep volume OUTCAR > CellVol.txt
	echo Finished with MP$i, moving to next directory...
	cd ..
	echo Finished!
done
