#!/bin/bash
#A script to run through all convergence files and do Phonopy post processing.

echo Post-processing energy convergence...
cd ECConvergence
for (( i=100; i<=600; i+=50 ))
do
	cd $i\eV
	phonopy -f POSCAR*/vasprun.xml
	phonopy --dim="1 1 1" --qpoints="0 0 0" --writedm
	outputconversion.sh
	echo Finished with $i - moving on...
	cd ..
done
echo Finished with energy convergence...
cd ..

echo Post-processing k-point convergence...
cd KptConvergance
for (( i=3; i<=11; i++ ))
do
        cd MP$i
        phonopy -f POSCAR*/vasprun.xml
        phonopy --dim="1 1 1" --qpoints="0 0 0" --writedm
        outputconversion.sh 
        echo Finished with MP$i - moving on...
        cd ..
done
echo Finished with k-point convergence...
cd ..

echo Finished!
