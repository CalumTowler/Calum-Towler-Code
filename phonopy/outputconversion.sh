#!/bin/bash

#A script to rename all the phonopy output files so PDielec will read them.

mv phonopy.yaml BORNphonopy.yaml
mv qpoints.yaml BORNqpoints.yaml
cd BORN/
cp OUTCAR OUTCAR.born
cd ..
echo Done!

