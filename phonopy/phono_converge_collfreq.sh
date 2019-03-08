#!/bin/bash
#A script to loop through the Phonopy convergence dirs and collect frequencies into two docs.

cd ECConvergence
touch ECFreqs.txt
for (( i=100; i<=600; i+=50 ))
do
	echo Starting cutoff energy $i\eV
	cd $i\eV
	echo Cutoff = $i eV >> ../ECFreqs.txt
	grep frequency BORNqpoints.yaml >> ../ECFreqs.txt
	cd ..
done
cd ..
pwd
cd KptConvergance
touch KptFreqs.txt
for (( i=3; i<=11; i++ ))
do
        echo Starting MP$i
	cd MP$i
        echo K-Point grid of $i >> ../KptFreqs.txt
        grep frequency BORNqpoints.yaml >> ../KptFreqs.txt
        cd ..
done
cd ..			
