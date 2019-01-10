#!/bin/bash

# A script to produce the necessary directories and copy files to them for a phonopy job.
# runphonopy [Jobname] [Final POSCAR Directory] [Number of cores (4 for small)]
# ToDo: make if/do  loop into 0-9 do x and 10+ do y | add functionality to make INCARs |
# Potential: Add script to rename POSCAR-XXX to POSCAR-X, simplifying loop.

#Loop to move correct files and rename them for VASP.
for (( i=1; i<=$2; i++ ))
do
#if [$2 -gt 9]
#then
# 	mkdir POSCAR_$i
#       	mv POSCAR-0$i POSCAR_$i/POSCAR
#       	cp POTCAR KPOINTS INCAR.supercell POSCAR_$i
#       	mv INCAR.supercell INCAR
#       	mkdir BORN
#       	mv INCAR.born BORN/INCAR
#       	mv SPOSCAR BORN/POSCAR
#       	cp KPOINTS POTCAR BORN
#else
        mkdir POSCAR_$i
       	mv POSCAR-00$i POSCAR_$i
       	cp POTCAR KPOINTS INCAR.supercell POSCAR_$i
	cd POSCAR_$i
	mv POSCAR-00$i POSCAR
	mv INCAR.supercell INCAR
	echo Finished with POSCAR $i
	cd ..
done

mkdir BORN
mv INCAR.born SPOSCAR BORN/
cp KPOINTS POTCAR BORN
cd BORN
mv INCAR.born INCAR
mv SPOSCAR POSCAR
cd ..
echo Finished with BORN

#Loop to run VASP jobs in each displacement folder.
for (( i=1; i<=$2; i++ ))
do
        cd POSCAR_$i
        runvasp $1_$i $3 48
	cd ..
	echo Submitted POSCAR $i VASP Job
done

cd BORN
runvasp $1_Born $3 48
cd ..
echo Submitted BORN VASP job
