#!/bin/bash

# A simple script to produce a new directory for a month containing all the necessary subfolders.
# VASP VERSION

echo Creating a directory called $1...
mkdir $1
cd $1

echo Creating necessary subfolders...
mkdir VASPFiles
mkdir Analysis
cd Analysis
mkdir PDielec
mkdir VASPy
mkdir PyMatGen

echo Finished!
