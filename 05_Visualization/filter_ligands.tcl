# --------------------------------------------------------------------------------
# Script: filter_ligands.tcl
# Description: Custom selection and removal of specific residues (PNP) 
# to adjust system concentration or configuration.
# Usage: vmd -dispdev text -e filter_ligands.tcl
# --------------------------------------------------------------------------------

# 1. Load the system (if not already loaded)
# mol new mem_10PNP1.pdb

# 2. Identify and select the ligand residues
set all_pnp [atomselect top "resname PNP"]
set pnp_residues [lsort -unique [$all_pnp get residue]]

puts "Current PNP residues: $pnp_residues"

# 3. Create a selection EXCLUDING specific residues
# We are filtering out residues: 5257, 5254, 5251, 5248, 5255
# to reduce the concentration from 10 to 5 molecules.
set filtered_system [atomselect top "not residue 5257 5254 5251 5248 5255"]

# 4. Save the new filtered system
set output_name "system_5pnp_reduced.pdb"
$filtered_system writepdb $output_name

puts "Successfully created $output_name with 5 PNP molecules."

# Cleanup
$all_pnp delete
$filtered_system delete
# exit
