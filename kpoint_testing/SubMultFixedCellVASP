#!/bin/bash

# A script to loop through multiple fixed cell optimisations and submit a dielectric phonon calc.

for (( i=$1; i<=$2; i++ ))
do
        vasp_fixedcell MP%i 12 4
        echo Submitting MP$i fixed cell optimisation...
        echo Done!
done
