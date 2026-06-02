#!/bin/bash

# --------------------------------------------------------------------------------

# Script: prepare_docking_system.sh

# Description: Automates ligand and receptor preparation for AutoDock Vina

# using MGLTools (AutoDockTools) python scripts.

# --------------------------------------------------------------------------------

# Convert ligand structure from PDB to PDBQT format.

# PDBQT contains atom types, charges, and rotatable bond information

# required by AutoDock Vina.
# -l: ligand file | -o: output file
pythonsh prepare_ligand4.py -l S-fluralaner.pdb -o S-fluralaner.pdbqt

# Convert receptor structure from PDB to PDBQT format.

# Hydrogens are added to ensure proper docking calculations.
# -r: receptor file | -A: add hydrogens | -o: output file
pythonsh prepare_receptor4.py -r rdl_3jad.pdb -A hydrogens -o rdl_3jad.pdbqt

# Preparation completed.

echo "System preparation for Vina complete."

