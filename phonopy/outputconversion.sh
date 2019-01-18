#!/bin/bash

#A script to rename all the phonopy output files so PDielec will read them.

mv phonopy.yaml BORNphonopy.yaml
mv qpoints.yaml BORNqpoints.yaml
cd BORN/
cp OUTCAR OUTCAR.born
cd ..
echo Files have been renamed...

mkdir Usefulfiles_$1_Phonopy
mkdir Usefulfiles_$1_Phonopy/BORN
cp BORNphonopy.yaml BORNqpoints.yaml Usefulfiles_$1_Phonopy
cp BORN/OUTCAR.born Usefulfiles_$1_Phonopy/BORN
echo Files have been copied...
echo Done

