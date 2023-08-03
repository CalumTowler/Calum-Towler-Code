#LM!/bin/bash
# Create variable KPOINT convergance directories.

# Help function and exit if error.
if [ $1 == '-h' ]; then
	echo 'Usage: VASPConvergence.sh [Name]'
	echo 'Make sure cif file is in ~/CIFs and everything will run.'
	exit 0
fi
set -e
#Create Files if they don't exist an
echo 'Creating starting files...'

if [ ! -e $1 ]; then
	cif2cell ~/CIFs/$1.cif -p vasp --setup-all
	grep ENCUT INCAR | awk '{print $3}' > RecomENCUT
	ENCUT=`cat RecomENCUT`
	ENCUT=${ENCUT/.*}
	ENCUT=`awk 'BEGIN { a = '$ENCUT'; print (a) }'`
	ENCUTMAX=`awk 'BEGIN { a = '$ENCUT'; print (a + a) }'`
	echo 'PREC    = Accurate ' > INCAR
	echo 'LREAL   = .FALSE.'   >> INCAR
	echo 'ISMEAR  = -5'        >> INCAR 
	echo 'SIGMA   = 0.05'      >> INCAR 
	echo 'IBRION  = -1'        >> INCAR 
	echo 'NFREE   = 10'        >> INCAR 
	echo 'POTIM   = 0.2'       >> INCAR 
	echo 'ISIF    = 3'         >> INCAR 
	echo 'NSW     = 0'         >> INCAR 
	echo 'NELMIN  = 4'         >> INCAR 
	echo 'LPLANE  = .TRUE.'    >> INCAR 
	echo 'NCORE   = 8'         >> INCAR 
	echo 'NSIM    = 2'         >> INCAR 
	echo 'ALGO    = FAST'      >> INCAR 
	echo 'EDIFF   = 5.0E-6'    >> INCAR 
	echo 'LMAXMIX = 4'         >> INCAR 
fi

# KPt Convergence
echo 'Setting up KPt Convergence...'
# Extract KPT value from recommended KPTs
mkdir KptConvergenceSPE
grep -A1 Gamma KPOINTS | grep -v "Gamma" | awk '{print $1}' > KPt1
grep -A1 Gamma KPOINTS | grep -v "Gamma" | awk '{print $2}' > KPt2
grep -A1 Gamma KPOINTS | grep -v "Gamma" | awk '{print $3}' > KPt3
KPt1=`cat KPt1`
KPt2=`cat KPt2`
KPt3=`cat KPt3`
# Make all KPTs odd or even
if [ $((KPt1%2)) -eq 0 ]; then
	let 'KPt1++'
	echo $KPt1  > KPt1
else
	echo $KPt1
fi
if [ $((KPt2%2)) -eq 0 ]; then
        let 'KPt2++'
        echo $KPt2  > KPt2
else
	echo $KPt2
fi
if [ $((KPt3%2)) -eq 0 ]; then
        let 'KPt3++'
        echo $KPt3  > KPt3
else
	echo $KPt3
fi
# Make new KPT master file
echo Gamma-point only   > KPOINTS
echo 0                 >> KPOINTS
echo Monkhorst Pack    >> KPOINTS
echo $KPt1 $KPt2 $KPt3 >> KPOINTS
echo 0 0 0             >> KPOINTS

cp INCAR POSCAR POTCAR KptConvergenceSPE
cd KptConvergenceSPE
# Create increasing KPT loop
for (( i=1; i<=3; i++ ))
do
	mkdir KPG$i
	cp INCAR POSCAR POTCAR KPG$i
	cd KPG$i
	touch KPOINTS
	echo Gamma-point only  > KPOINTS
	echo 0                 >> KPOINTS
	echo Monkhorst Pack    >> KPOINTS
	echo $KPt1 $KPt2 $KPt3 >> KPOINTS
	echo 0 0 0             >> KPOINTS
	echo ENCUT   = 450     >> INCAR
	echo NPAR    = 2       >> INCAR
	runvasp $1_KPG$i 8 48
	let 'KPt1++'
	let 'KPt2++'
	let 'KPt3++'
	cd ..
done
cd ..

#CO Convergence
echo 'Setting up ENCUT convergence ...'
# Convergence set up between recommended value and +300 eV
mkdir ECConvergenceSPE
cp INCAR POSCAR POTCAR KPOINTS ECConvergenceSPE
cd ECConvergenceSPE

for (( i=$ENCUT; i<=$ENCUTMAX; i+=50 ))
do
	mkdir EC$i
	cp INCAR POSCAR POTCAR KPOINTS EC$i
	cd EC$i
	echo 'ENCUT = '$i >> INCAR
	echo NPAR    = 2       >> INCAR
	runvasp $1_EC$i
	cd ..
done
cd ..

# Make Test calculation with recommended values.
echo 'Setting up recommended calculation'

mkdir RecomValues
cp INCAR POSCAR POTCAR KPOINTS RecomValues
cd RecomValues
echo ENCUT = $ENCUT >> INCAR
echo NPAR    = 6    >> INCAR
sed -i -e 's/IBRION  = -1/IBRION  = 1/g' INCAR
sed -i -e 's/NSW     = 0/NSW     = 1000/g' INCAR
runvasp $1_RV 24 48
cd ..

# Cleaning Up

mkdir Variables
mv KPt* RecomENCUT Variables
echo Finished!



