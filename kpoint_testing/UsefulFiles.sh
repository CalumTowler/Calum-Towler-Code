#!/bin/bash

# A script to collect all the useful files for transfer to laptop/permanent storage.

mkdir UsefulFiles_$1
echo Making parent directory...

for (( i=$2; i<=$3; i++ ))
do
	cd MP$i
	cp *.script *.log CONTCAR DOSCAR DYNMAT EIGENVAL INCAR KPOINTS OSZICAR OUTCAR vasprun.xml WAVECAR XDATCAR ../UsefulFiles
	cd FixedCell
	cp *.script *.log CONTCAR DOSCAR EIGENVAL INCAR OSZICAR OUTCAR vasprun.xml WAVECAR XDATCAR ../../UsefulFiles
	cd Dielectric
	cp *.script *.log INCAR OSZICAR OUTCAR vasprun.xml WAVECAR ../../../UsefulFiles
	cd ../../..
done
