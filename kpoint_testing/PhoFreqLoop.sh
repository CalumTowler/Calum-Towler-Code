#!/bin/bash

# A script that loops through the directories, searches for the phonon frequencies in the OUTCAR and writes it to a file called PhoFreq.txt

for (( i=$1; i<=$2; i++ ))
do
        cd MP$i/FixedCell/Dielectric
	echo MP$i > PhoFreq.txt
	grep THz OUTCAR >> PhoFreq.txt
        echo Finished with MP$i, moving to next directory...
        cd ../../..
        echo Finished!
done

