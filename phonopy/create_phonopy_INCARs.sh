#!/bin/bash

# A script to produce to necessary INCAR files for a Phonopy calculation.

# Creating INCAR.born
touch INCAR.born
echo ENCUT = $1 >> INCAR.born
echo LMAXMIX = 4 >> INCAR.born
echo IBRION = -1       ! No Change  >> INCAR.born
echo POTIM = 0.2      ! Scaling factor for forces >> INCAR.born
echo ISIF   = 3       ! 3=optimise cell and ions, 2=optimise ions >> INCAR.born
echo NSW    = 1      ! If this is not set there is no calculation of normal modes >> INCAR.born
echo NELMIN = 4       ! The minimum number of electronic optimisation steps >> INCAR.born
echo PREC   = Accurate >> INCAR.born
echo ISMEAR = -5       ! Smearing method 0=Gaussian, -5=tetrahedron  >> INCAR.born
echo SIGMA  = 0.05    ! Width of smearing >> INCAR.born
echo EDIFF  = 5E-8    ! A bit more accurate >> INCAR.born
echo ALGO = Fast >> INCAR.born
echo LREAL = .FALSE. >> INCAR.born
echo LWAVE = .FALSE. >> INCAR.born
echo LREAL  = .FALSE. >> INCAR.born
echo LCHARG = .FALSE. >> INCAR.born
echo LASPH = .TRUE. >> INCAR.born
echo LEPSILON = .TRUE. >> INCAR.born

# Creating INCAR.supercell
touch INCAR.supercell
echo ENCUT = $1 >> INCAR.supercell
echo LMAXMIX = 4 >> INCAR.supercell
echo IBRION = -1       ! No Change  >> INCAR.supercell
echo POTIM = 0.2      ! Scaling factor for forces >> INCAR.supercell
echo ISIF   = 3       ! 3=optimise cell and ions, 2=optimise ions >> INCAR.supercell
echo NSW    = 1      ! If this is not set there is no calculation of normal modes >> INCAR.supercell
echo NELMIN = 4       ! The minimum number of electronic optimisation steps >> INCAR.supercell
echo PREC   = Accurate >> INCAR.supercell
echo ISMEAR = -5       ! Smearing method 0=Gaussian, -5=tetrahedron >> INCAR.supercell
echo SIGMA  = 0.05    ! Width of smearing >> INCAR.supercell
echo EDIFF  = 5E-8    ! A bit more accurate >> INCAR.supercell
echo ALGO = Fast >> INCAR.supercell
echo LREAL = .FALSE. >> INCAR.supercell
echo LWAVE = .FALSE. >> INCAR.supercell
echo LREAL  = .FALSE. >> INCAR.supercell
echo LCHARG = .FALSE. >> INCAR.supercell
echo LASPH = .TRUE. >> INCAR.supercell
