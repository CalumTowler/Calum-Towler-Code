#!/bin/bash

# A script to loop through multiple fixed cell optimisations and submit a dielectric phonon calc.

for (( i=$1; i<=$2; i++ ))
do
	cd MP$i/
	vasp_dielectric FixedCell 24 48
        echo Submitting MP$i dielectric calculation..
        cd ..
	echo Done!
done
