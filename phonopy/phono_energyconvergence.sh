#!/bin/bash

# A script to produce multiple Phonopy calculations which test the convergance of the cutoff energy.

read OrderofMag
mkdir ECConvergence
cp INCAR.born INCAR.supercell POSCAR POTCAR KPOINTS ECConvergence
cd ECConvergence
for (( i=100; i<=600; i+=50 ))
do
        echo Making directory...
        mkdir $i\eV
        cp INCAR.born INCAR.supercell POSCAR POTCAR KPOINTS $i\eV
        echo Copying files and adding cut-off energy...
        cd $i\eV
        echo ENCUT = $i >> INCAR.born
        echo ENCUT = $i >> INCAR.supercell
	echo Producing Phonopy files and submitting VASP job...
	phonopy -d --dim="1 1 1"
	if [ OrderofMag=1 ]
	then
		runphonopy.sh $1 $2 
	elif [ OrderofMag=2 ]
	then
		runphonopyZP10.sh $1 $2 
	else [ OrderofMag=3 ]
		runphonopyZP100.sh $1 $2 
	fi
	echo Finished with this cut-off energy, moving onto the next..
	cd ..
done

echo Finished!

