#!/bin/bash

# A script that loops through the directories, searches for the phonon frequencies in the OUTCAR and writes it to a file called PhoFreq.txt

touch AllCellDims AllCellVols AllPhoFreqs

for (( i=$1; i<=$2; i++ ))
do
        cd MP$i/
	cat CellDim.txt >> ../AllCellDims
	cat CellVol.txt >> ../AllCellVols
#	cd FixedCell/Dielectric
#	cat PhoFreq.txt >> ../../../AllPhoFreqs
        echo Finished with MP$i, moving to next directory...
	cd ..
#        cd ../../..
        echo Finished!
done

