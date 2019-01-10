#!/bin/bash

# A script to run vasp calculations for Phonopy.

for d in BORN-* DISP-*
     do
     runvasp $d
     done
