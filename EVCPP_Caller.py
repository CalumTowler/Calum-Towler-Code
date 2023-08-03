#!/home/home02/cm14cnat/anaconda3/bin/python

from EVCurve_POSCAR_Producer import EVCurve_POSCAR_Producer
import sys

#if len(sys.argv) == 0:
x = EVCurve_POSCAR_Producer()
x.initial_POSCAR_reader()
x.create_variables()
x.produce_structures_percentage()
x.create_POSCARs()
x.move_files()
#elif len(sys.argv) <= 2:
#    x = EVCurve_POSCAR_Producer(sys.argv[1])
#    x.initial_POSCAR_reader()
#    x.create_variables()
#    x.produce_structures_percentage()
#    x.create_POSCARs()
#    x.move_files()
#elif len(sys.argv) <= 3:
#    x = EVCurve_POSCAR_Producer(sys.argv[1], sys.argv[2])
#    x.initial_POSCAR_reader()
#    x.create_variables()
#    x.produce_structures_percentage()
#    x.create_POSCARs()
#    x.move_files()
#else:
#    x = EVCurve_POSCAR_Producer(sys.argv[1], sys.argv[2], sys.argv[3])
#    x.initial_POSCAR_reader()
#    x.create_variables()
#    x.produce_structures_percentage()
#    x.create_POSCARs()
#    x.move_files()
