#!/bin/bash
#A script to run through starting files and set up a test VASP calculation at 300eV and 5 Kpoints.

cif2cell -p VASP *.cif
grep Species POSCAR

read Species 
POTCARGeneration.sh $Species

cp ~/bin/scripts/INCAR.optimise .
echo "ENCUT = 300" >> INCAR.optimise
mv INCAR.optimise INCAR

touch KPOINTS
echo "Gamma-point only" >> KPOINTS
echo "0" >> KPOINTS
echo "Monkhorst Pack" >> KPOINTS
echo "5 5 5" >> KPOINTS
echo "0 0 0" >> KPOINTS

cif2cell -p VASP *.cif

runvasp $1 12 48
