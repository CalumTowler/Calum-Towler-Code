#!/bin/bash

# A script to produce the necessary directories and copy files to them for a phonopy job.
# runphonopy  [Jobname] [Final POSCAR Directory] 
# ToDo:  

#Loop to move correct files and rename them for VASP.
for (( i=1; i<=9; i++ ))
do
        mkdir POSCAR00$i
       	mv POSCAR-00$i POSCAR00$i
       	cp POTCAR KPOINTS INCAR.supercell POSCAR00$i
	cd POSCAR00$i
	mv POSCAR-00$i POSCAR
	mv INCAR.supercell INCAR
	echo Finished with POSCAR $i
	cd ..
done

for (( i=10; i<=99; i++ ))
do
        mkdir POSCAR0$i
        mv POSCAR-0$i POSCAR0$i
        cp POTCAR KPOINTS INCAR.supercell POSCAR0$i
        cd POSCAR0$i
        mv POSCAR-0$i POSCAR
        mv INCAR.supercell INCAR
        echo Finished with POSCAR $i
        cd ..
done

for (( i=100; i<=$2; i++ ))
do
        mkdir POSCAR$i
        mv POSCAR-$i POSCAR$i
        cp POTCAR KPOINTS INCAR.supercell POSCAR$i
        cd POSCAR$i
        mv POSCAR-$i POSCAR
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
for (( i=1; i<=9; i++ ))
do
        cd POSCAR00$i
        runvasp $1_$i 1 48
	cd ..
	echo Submitted POSCAR $i VASP Job
done

for (( i=10; i<=99; i++ ))
do
        cd POSCAR0$i
        runvasp $1_$i 1 48
        cd ..
        echo Submitted POSCAR $i VASP Job
done

for (( i=100; i<=$2; i++ ))
do
        cd POSCAR$i
        runvasp $1_$i 1 48
        cd ..
        echo Submitted POSCAR $i VASP Job
done

cd BORN
runvasp $1_Born 24 48
cd ..
echo Submitted BORN VASP job
