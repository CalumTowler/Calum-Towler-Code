#!/bin/bash
# Creates and submits Phonopy convergence jobs for Kpt convergence
# phono_kptconvergence Jobname FinalDirNo.

read OrderofMag
mkdir KptConvergance
cp INCAR.born INCAR.supercell POSCAR POTCAR KptConvergance
cd KptConvergance
echo ENCUT = 300 >> INCAR.born
echo ENCUT = 300 >> INCAR.supercell

echo Creating MP subdirectories...
for (( i=3; i<=11; i++ ))
do
        mkdir MP$i
        cp INCAR.born INCAR.supercell POSCAR POTCAR MP$i
        cd MP$i
        touch KPOINTS
        echo Gamma-point only > KPOINTS
        echo 0                >> KPOINTS
        echo Monkhorst Pack   >> KPOINTS
        echo $i $i $i         >> KPOINTS
        echo 0 0 0            >> KPOINTS
        echo Producing Phonopy files and submitting VASP job...
        phonopy -d --dim="1 1 1"
        if [ OrderofMag=1 ]
        then
                runphonopy.sh $1 $2
        elif [ OrderofMag=2 ]
        then
                runphonopyZP10.sh $1 $2
        else [ OrderofMag=3 ]
                runphonopyZP100.sh $1 $2
        fi
        echo Finished with this cut-off energy, moving onto the next..
        cd ..
done
echo Finished!
