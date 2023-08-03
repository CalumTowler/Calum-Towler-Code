#!/home/home02/cm14cnat/anaconda3/bin/python

from EVCurve_POSCAR_Producer import EVCurve_POSCAR_Producer

x = EVCurve_POSCAR_Producer()
x.read_filenames_later()
x.run_phonopy()
