#!/bin/bash

# A script to collect all the useful files for transfer to laptop/permanent storage.

mkdir UsefulFiles_$1
mkdir UsefulFiles_$1/FixedCell
mkdir UsefulFiles_$1/FixedCell/Dielectric
echo Making parent directory and subdirectories...

for (( i=$2; i<=$3; i++ ))
do
	echo Copying useful files...
	cd MP$i
	cp *.script *.log CONTCAR DOSCAR DYNMAT EIGENVAL INCAR KPOINTS OSZICAR OUTCAR vasprun.xml WAVECAR XDATCAR ../UsefulFiles_$1
	cd FixedCell
	cp *.script *.log CONTCAR DOSCAR EIGENVAL INCAR OSZICAR OUTCAR vasprun.xml WAVECAR XDATCAR ../../UsefulFiles_$1
	cd Dielectric
	cp *.script *.log INCAR OSZICAR OUTCAR vasprun.xml WAVECAR ../../../UsefulFiles_$1
	cd ../../..
	echo Completed MP$i, moving to next folder...
done

echo Finished!
