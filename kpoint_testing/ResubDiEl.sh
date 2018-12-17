#!/bin/bash

#A script to resubmit multiple dielectric calculations
for (( i=$1; i<=$2; i++ ))
do
        cd MP$i/FixedCell/Dielectric
        qsub d_FixedCell.script
        cd ../../..
        echo Submitted MP$i
done

