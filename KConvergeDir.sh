#!/bin/bash
# Create new named directory with variable KPOINT convergance directories.

echo Creating $1 ...
mkdir $1
cd $1

echo Creating $2 MP subdirectories...
for (( i=1; i<=$2; i++ ))
do
	mkdir MP$i
	cd MP$i
	touch KPOINTS POSCAR INCAR
	cd ..			
done

echo Finished!



