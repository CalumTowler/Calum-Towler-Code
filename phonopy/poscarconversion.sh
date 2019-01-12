#!/bin/bash

#A script to rename all phonopy generated POSCAR files so they are easier to manipulate.

for (( i=1; i<=9; i++ ))
do
	mv POSCAR-00$i POSCAR-$i
done

for (( i=10; i<=99; i++ ))
do
	mv POSCAR-0$i POSCAR-$i
done

#for (( i=100; i<=$1; i++ ))
#do
#	mv POSCAR-$i
	
