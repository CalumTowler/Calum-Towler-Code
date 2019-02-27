#!/bin/bash

# A script to collect all the useful files for transfer to laptop/permanent storage.

echo Making parent directory...
mkdir UsefulFiles_$1_`date +%F`

mkdir UsefulFiles_$1/FixedCell
mkdir UsefulFiles_$1//FixedCell/Dielectric

echo Copying useful files...
cp *.script *.log CONTCAR DOSCAR EIGENVAL INCAR KPOINTS OSZICAR OUTCAR vasprun.xml UsefulFiles_$1
cd FixedCell
cp *.script *.log CONTCAR DOSCAR EIGENVAL INCAR OSZICAR OUTCAR vasprun.xml ../UsefulFiles_$1/FixedCell
cd Dielectric
cp *.script *.log INCAR OSZICAR OUTCAR vasprun.xml ../../UsefulFiles_$1/FixedCell/Dielectric
cd ../../

echo Finished!

