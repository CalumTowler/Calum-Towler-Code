#!/bin/bash

# A script that generates a VASP/Phonopy POTCAR file by concacting the individual POTCAR files in the correct order.
# Usage: POTCARGeneration.sh [Elements] [In] [Order] [They] [Appear] [In] [POSCAR]

for POTCAR in "$@"; do
        if [ ! -e ~/VaspPseudopotentials/$POTCAR ]; then
                echo "$POTCAR does not exist"
                exit
        fi
done

for POTCAR in "$@"; do
        cp ~/VaspPseudopotentials/$POTCAR/POTCAR .
        chmod u+w POTCAR
        mv POTCAR POTCAR$POTCAR
done

touch POTCAR
for POTCAR in "$@"; do
        cat POTCAR$POTCAR >> POTCAR
        rm POTCAR$POTCAR
done
