#!/bin/bash

#A script to produce the correct INCAR file for a SPE calculation and GeomOpt.

touch INCAR.SPE
echo IBRION = -1 > INCAR.SPE
echo POTIM = 0.2 >> INCAR.SPE
echo ISIF = 3 >> INCAR.SPE
echo NSW = 50 >> INCAR.SPE
echo NELMIN = 4 >> INCAR.SPE
echo LPANE = .TRUE. >> INCAR.SPE
echo NPAR = 8 >> INCAR.SPE
echo PREC = Accurate >> INCAR.SPE
echo LREAL = AUTO >> INCAR.SPE
echo ISMEAR = -5 >> INCAR.SPE
echo SIGMA = 0.05 >> INCAR.SPE
echo LMAXMIX = 4 >> INCAR.SPE
echo LASPH =.TRUE. >> INCAR.SPE

touch INCAR.GO
echo IBRION = 1 > INCAR.GO
echo POTIM = 0.2 >> INCAR.GO
echo ISIF = 3 >> INCAR.GO
echo NSW = 50 >> INCAR.GO
echo NELMIN = 4 >> INCAR.GO
echo LPANE = .TRUE. >> INCAR.GO
echo NPAR = 8 >> INCAR.GO
echo PREC = Accurate >> INCAR.GO
echo LREAL = AUTO >> INCAR.GO
echo ISMEAR = -5 >> INCAR.GO
echo SIGMA = 0.05 >> INCAR.GO
echo LMAXMIX = 4 >> INCAR.GO
echo LASPH =.TRUE. >> INCAR.GO

