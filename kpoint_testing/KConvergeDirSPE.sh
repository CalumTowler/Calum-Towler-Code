#!/bin/bash
# Create variable KPOINT convergance directories.

mkdir KptConverganceSPE
cp INCAR.SPE POSCAR POTCAR KptConverganceSPE
cd KptConverganceSPE
mv INCAR.SPE INCAR
echo ENCUT = 200 >> INCAR

echo Creating MP subdirectories...
for (( i=$1; i<=$2; i++ ))
do
	mkdir MP$i
	cp INCAR POSCAR POTCAR MP$i
	cd MP$i
	touch KPOINTS
	echo Gamma-point only > KPOINTS
	echo 0                >> KPOINTS
	echo Monkhorst Pack   >> KPOINTS
	echo $i $i $i         >> KPOINTS
        echo 0 0 0            >> KPOINTS
	cd ..		
done

echo Finished!



