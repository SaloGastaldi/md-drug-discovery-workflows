#!/bin/bash
# --------------------------------------------------------------------------------
# Script: prepare_docking_system.sh
# Description: Automates ligand and receptor preparation for AutoDock Vina
# using MGLTools (AutoDockTools) python scripts.
# --------------------------------------------------------------------------------

# 1. Prepare Ligand: Convert PDB to PDBQT
# -l: ligand file | -o: output file
pythonsh prepare_ligand4.py -l S-fluralaner.pdb -o S-fluralaner.pdbqt

# 2. Prepare Receptor: Convert PDB to PDBQT adding hydrogens
# -r: receptor file | -A: add hydrogens | -o: output file
pythonsh prepare_receptor4.py -r rdl_3jad.pdb -A hydrogens -o rdl_3jad.pdbqt

echo "System preparation for Vina complete."
