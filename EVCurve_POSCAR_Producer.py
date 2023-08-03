import numpy as np
import string
import os
import sys
import shutil
import fileinput


def string_replacer(target_file, target_string, replacement_string):
    for line in fileinput.input(target_file, inplace=1):
        if target_string in line:
            line = line.replace(target_string, replacement_string)
        sys.stdout.write(line)


class EVCurve_POSCAR_Producer:

    def __init__(self, number_of_POSCARs = 6, step_size = 0.05, filename = 'POSCAR'):
        self.number_of_POSCARs = number_of_POSCARs
        self.filename = filename
        self.step_size = float(step_size)

    def initial_POSCAR_reader(self):
        with open(self.filename, 'r') as file:
            list = file.readlines()
            self.header = list[0]
            self.unit_cell_constant = list[1]
            self.unit_cell_dimensions = list[2:5]
            self.number_of_atoms_list = list[6]
            self.atom_positions = list[8:]

        return self.header, self.unit_cell_constant, self.unit_cell_dimensions, self.number_of_atoms_list, self.atom_positions

    def create_variables(self):
        self.unit_cell_constant_float = float(str.split(self.unit_cell_constant)[0])

        unit_cell_dimensions_split = []
        for i in self.unit_cell_dimensions:
            unit_cell_dimensions_split.append(str.split(i))
        unit_cell_dimensions_array = np.array(unit_cell_dimensions_split)

        number_of_atoms_split = []
        number_of_atoms_split = str.split(self.number_of_atoms_list)
        c1 = 0
        while c1 < len(number_of_atoms_split):
            number_of_atoms_split[c1] = int(number_of_atoms_split[c1])
            c1 += 1
        self.number_of_atoms = sum(number_of_atoms_split)

        atom_positions_split = []
        for i in self.atom_positions:
            atom_positions_split.append(str.split(i))
        self.atom_positions_array = np.array(atom_positions_split)

        expanded_unit_cell_dimensions_array = unit_cell_dimensions_array.astype(np.float)
        self.expanded_unit_cell_dimensions_array = expanded_unit_cell_dimensions_array * self.unit_cell_constant_float

        return self.unit_cell_constant_float, self.number_of_atoms, self.atom_positions_array, self.expanded_unit_cell_dimensions_array

    def produce_structures_stepsize(self):
        if int(self.number_of_POSCARs) % 2 == 1:
            self.number_of_POSCARs = int(self.number_of_POSCARs) + 1
        self.alterations = [self.step_size, -self.step_size]
        c4 = 0
        c5 = int(self.number_of_POSCARs)/2 - 1
        step = self.step_size
        while c4 < c5:
            step += self.step_size
            step = format(step, '.2f')
            step = float(step)
            self.alterations.append(step)
            self.alterations.append(-step)
            c4 += 1
        self.alterations.sort()
        self.POSCAR_names = []
        for i in self.alterations:
            self.POSCAR_names.append('POSCAR' + str(i))

        self.dict_of_collapsed_structures = {}
        for i in self.alterations:
            c2 = 0
            c3 = 0
            test = (3,3)
            new_position1 = np.zeros(test)
            while c3 < np.size(self.expanded_unit_cell_dimensions_array,0):
                c2 = 0
                while c2 < np.size(self.expanded_unit_cell_dimensions_array,1):
                    if self.expanded_unit_cell_dimensions_array[c2, c3] == 0:
                        pass
                    elif self.expanded_unit_cell_dimensions_array[c2, c3] < 0:
                        new_position1[c2, c3] = self.expanded_unit_cell_dimensions_array[c2, c3] - i
                    else:
                        new_position1[c2, c3] = self.expanded_unit_cell_dimensions_array[c2, c3] + i
                    c2 += 1
                c3 += 1

                collapsed_unit_cell_dimensions_array = new_position1 / self.unit_cell_constant_float
            self.dict_of_collapsed_structures[i] = collapsed_unit_cell_dimensions_array

        return self.alterations, self.POSCAR_names, self.dict_of_collapsed_structures

    def produce_structures_percentage(self):
        self.alterations = [-0.06]
        self.POSCAR_names = []
        self.dict_of_collapsed_structures = {}
        for i in self.alterations:
            self.POSCAR_names.append('POSCAR' + str(i))
        for i in self.alterations:
            c2 = 0
            c3 = 0
            test = (3, 3)
            new_position1 = np.zeros(test)
            while c3 < np.size(self.expanded_unit_cell_dimensions_array, 0):
                c2 = 0
                while c2 < np.size(self.expanded_unit_cell_dimensions_array, 1):
                    if self.expanded_unit_cell_dimensions_array[c2, c3] == 0:
                        pass
                    else:
                        change = (self.expanded_unit_cell_dimensions_array[c2, c3] * i)
                        new_position1[c2, c3] = self.expanded_unit_cell_dimensions_array[c2, c3] + change
                    c2 += 1
                c3 += 1
                collapsed_unit_cell_dimensions_array = new_position1 / self.unit_cell_constant_float
            self.dict_of_collapsed_structures[i] = collapsed_unit_cell_dimensions_array

        return self.alterations, self.POSCAR_names, self.dict_of_collapsed_structures




    def create_POSCARs(self):
#        os.chdir(self.path)
        if os.path.isdir('POSCARs') == True:
            os.chdir('POSCARs')
        else:
            os.mkdir('POSCARs')
            os.chdir('POSCARs')

        c5 = 0
        while c5 < len(self.POSCAR_names):
            with open(self.POSCAR_names[c5], 'w') as POSCAR1:
                for j in self.alterations:
                    POSCAR1.write(self.header)
                    POSCAR1.write('   ' + str(self.unit_cell_constant_float) + '\n')
                    POSCAR1.write('   ' + str(self.dict_of_collapsed_structures[self.alterations[c5]][0,0])
                                              + '   ' + str(self.dict_of_collapsed_structures[self.alterations[c5]][0,1])
                                              + '   ' + str(self.dict_of_collapsed_structures[self.alterations[c5]][0,2]) + '\n')
                    POSCAR1.write('   ' + str(self.dict_of_collapsed_structures[self.alterations[c5]][1,0])
                                              + '   ' + str(self.dict_of_collapsed_structures[self.alterations[c5]][1,1])
                                              + '   ' + str(self.dict_of_collapsed_structures[self.alterations[c5]][1,2]) + '\n')
                    POSCAR1.write('   ' + str(self.dict_of_collapsed_structures[self.alterations[c5]][2,0])
                                              + '   ' + str(self.dict_of_collapsed_structures[self.alterations[c5]][2,1])
                                              + '   ' + str(self.dict_of_collapsed_structures[self.alterations[c5]][2,2]) + '\n')
                    POSCAR1.write(self.number_of_atoms_list)
                    POSCAR1.write('Direct \n')
                    for k in self.atom_positions:
                        POSCAR1.write(k)
            c5 += 1
        os.chdir('..')

    def move_files(self):
        c6 = 0
        runvasp1 = 'runvasp EVCurve 1 48'
        runvasp2 = 'runvasp GO 24 48'
        if os.path.isfile('INCAR'):
            os.mkdir('POSCAR0')
            shutil.copy('INCAR', 'POSCAR0')
            shutil.copy('KPOINTS', 'POSCAR0')
            shutil.copy('POTCAR', 'POSCAR0')
            shutil.copy('POSCAR', 'POSCAR0')

            os.chdir('POSCAR0')
            string_replacer('INCAR', 'IBRION = 1', 'IBRION = -1')
            os.system(runvasp1)
            os.chdir('..')

            string_replacer('INCAR', 'IBRION = -1', 'IBRION = 1')
            while c6 < len(self.POSCAR_names):
                os.mkdir(self.POSCAR_names[c6])
                shutil.copy('INCAR', str(self.POSCAR_names[c6]))
                shutil.copy('KPOINTS', str(self.POSCAR_names[c6]))
                shutil.copy('POTCAR', str(self.POSCAR_names[c6]))
                shutil.copy('POSCARs/' + str(self.POSCAR_names[c6]), str(self.POSCAR_names[c6]))
                shutil.copy('WAVECAR', str(self.POSCAR_names[c6]))
                os.rename(str(self.POSCAR_names[c6]) + '/' + str(self.POSCAR_names[c6]), str(self.POSCAR_names[c6]) + '/' + 'POSCAR')

                os.chdir(self.POSCAR_names[c6])
                os.system(runvasp2)
                os.chdir('..')
                c6 += 1
        else:
            print('Move INCAR, KPOINTS, WAVECAR and POTCAR into directory and try again.')
            sys.exit()

    def read_filenames_later(self):
        self.POSCAR_names = os.listdir('POSCARs')

        return self.POSCAR_names

    def run_phonopy(self):
        c7 = 0
        runphonopy = 'runphonopy.sh POSCAR0'
        os.chdir('POSCAR0')
        os.mkdir('phonopy')
        shutil.copy('INCAR', 'phonopy')
        shutil.copy('KPOINTS', 'phonopy')
        shutil.copy('POTCAR', 'phonopy')
        shutil.copy('POSCAR', 'phonopy')
        os.chdir('phonopy')
        os.system(runphonopy)
        os.chdir('../../')

        while c7 < len(self.POSCAR_names):
            runphonopy = 'runphonopy.sh ' + str(self.POSCAR_names[c7])
            os.chdir(self.POSCAR_names[c7])
            dir_contents_list = [os.path.isfile(os.path.join('.', f)) for f in os.listdir('.')]
            c8 = 2
            c9 = 2
            while not all(dir_contents_list):
                iteration_string = 'GOIter' + str(c8)
                os.chdir(iteration_string)
                dir_contents_list = [os.path.isfile(os.path.join('.', f)) for f in os.listdir('.')]
                c8 += 1
                c9 += 1
            back_to_root_string = '../' * c9
            os.mkdir('phonopy')
            shutil.copy('INCAR', 'phonopy')
            shutil.copy('KPOINTS', 'phonopy')
            shutil.copy('POTCAR', 'phonopy')
            shutil.copy('POSCAR', 'phonopy')
            os.chdir('phonopy')
            os.system(runphonopy)
            os.chdir(back_to_root_string)
            c7 += 1
