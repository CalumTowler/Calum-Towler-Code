#!/bin/bash

# A script to collect all the useful files for transfer to laptop/permanent storage.
if [[ $# < 2 ]] ; then
  echo "vasp_dielectric directory number_of_processors"
  echo "This command creates a sub directory in FixedCell (if it exists)"
  echo "and submits a job to the queue to calculate the dielectric properties"
  exit
fi
echo Making parent directory...
mkdir UsefulFiles_$1_`date +%F`

mkdir UsefulFiles_$1_`date +%F`/FixedCell
mkdir UsefulFiles_$1_`date +%F`/FixedCell/Dielectric

echo Copying useful files...
cp *.script *.log CONTCAR INCAR KPOINTS OSZICAR OUTCAR POSCAR  vasprun.xml UsefulFiles_$1
cd FixedCell
cp *.script *.log CONTCAR DOSCAR EIGENVAL INCAR OSZICAR OUTCAR vasprun.xml ../UsefulFiles_$1/FixedCell
cd Dielectric
cp *.script *.log INCAR OSZICAR OUTCAR vasprun.xml ../../UsefulFiles_$1/FixedCell/Dielectric
cd ../../

echo Finished!

