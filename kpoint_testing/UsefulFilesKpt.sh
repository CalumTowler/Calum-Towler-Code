#!/bin/bash

# A script to collect all the useful files for transfer to laptop/permanent storage.

echo Making parent directory...
mkdir UsefulFiles_$1
echo Extracting cell volumes...
CellVolLoop.sh $2 $3
echo Extracting phonon frequencies...
PhoFreqLoop.sh $2 $3
echo Extracting cell dimensions...
CellDimLoop.sh $2 $3
echo Collecting properties...
CatCalcProp.sh $2 $3
mv AllCellDims AllPhoFreqs AllCellVols UsefulFiles_$1 

for (( i=$2; i<=$3; i++ ))
do
	echo Making MP$i subdirectories...
	mkdir UsefulFiles_$1/MP$i
	mkdir UsefulFiles_$1/MP$i/FixedCell
	mkdir UsefulFiles_$1/MP$i/FixedCell/Dielectric  
	echo Copying useful files...
	cd MP$i
	cp *.script *.log CONTCAR DOSCAR EIGENVAL INCAR KPOINTS OSZICAR OUTCAR vasprun.xml WAVECAR XDATCAR CellVol.txt CellDim.txt ../UsefulFiles_$1/MP$i
	cd FixedCell
	cp *.script *.log CONTCAR DOSCAR EIGENVAL INCAR OSZICAR OUTCAR vasprun.xml WAVECAR XDATCAR ../../UsefulFiles_$1/MP$i/FixedCell
	cd Dielectric
	cp *.script *.log INCAR OSZICAR OUTCAR vasprun.xml WAVECAR PhoFreq.txt ../../../UsefulFiles_$1/MP$i/FixedCell/Dielectric
	cd ../../..
	echo Completed MP$i, moving to next folder...
done

echo Finished!
