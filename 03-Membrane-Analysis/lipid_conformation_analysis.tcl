# --------------------------------------------------------------------------------
# Script: lipid_conformation_analysis.tcl
# Description: Calculates the trans/gauche fraction and transition states 
# for lipid hydrocarbon chains (C1-C18).
# --------------------------------------------------------------------------------

# Parameters
set nresid 476
set fileout [open "lipid_trans_fraction.dat" w]
set num_steps [molinfo top get numframes]
set SL_chain {C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 C11 C12 C13 C14 C15 C16 C17 C18} 

# Selection
set sel1 [atomselect top "name $SL_chain and resid $nresid"] 

# Logic: Categorizes dihedrals into Trans (>120 or <-120), 
# Gauche+ (0 to 120), and Gauche- (-120 to 0).
# [ ... código optimizado con bucles para el cálculo de estadísticas ... ]

puts $fileout "# Dihed_ID | Trans_Avg | Trans_TG | Trans_GpGm | Trans_GmGp"
# [ ... loop de impresión de resultados ... ]

close $fileout
