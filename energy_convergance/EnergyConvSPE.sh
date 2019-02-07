#!/bin/bash

# A script to produce and submit multiple calculations which test the convergance of the cutoff energy.

mkdir EnergyConverganceSPE
cp KPOINTS POSCAR POTCAR INCAR.SPE EnergyConverganceSPE
cd EnergyConverganceSPE
mv INCAR.SPE INCAR

for (( i=$1; i<=$2; i+=50 ))
do 
	echo Making directory...
	mkdir $i\eV 
	cp INCAR POSCAR POTCAR KPOINTS $i\eV
	echo Copying files and adding cut-off energy...
	cd $i\eV
	echo ENCUT = $i >> INCAR
	echo Submitting job...
	runvasp EC$i\eV 8 48
	cd ..
	echo Finished with this directory, moving onto the next..
done

echo Finished!
