#!/bin/bash

# A script that loops through the directories, searches for the cell dimensions in the OUTCAR and writes it to a file called CellDim.txt

for (( i=$1; i<=$2; i++ ))
do
        cd MP$i
        echo MP$i > CellDim.txt
        grep -A 1 length OUTCAR >> CellDim.txt
        echo Finished with MP$i, moving to next directory...
        cd ..
        echo Finished!
done

