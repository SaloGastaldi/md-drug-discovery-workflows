#!/bin/bash

# --------------------------------------------------------------------------------

# Script: run_vina_ensemble.sh

# Description: Automates AutoDock Vina execution across multiple protein pockets.

# Ensemble docking allows evaluation of ligand binding across multiple receptor

# conformations or binding sites, incorporating protein flexibility into the

# screening workflow.

# --------------------------------------------------------------------------------

# List of receptor conformations / binding pockets
POCKETS=("TM1-A_TM3-E" "TM1-B_TM3-A" "TM1-C_TM3-B" "TM1-D_TM3-C" "TM1-E_TM3-D")

for FOLDER in "${POCKETS[@]}"; do
    # Check whether the target docking directory exists
    if [ -d "$FOLDER" ]; then
        echo "Processing pocket: $FOLDER"
        
        # Copy prepared ligand files into the docking workspace
        cp *.pdbqt "$FOLDER/"
        
        # Enter docking directory and execute AutoDock Vina
        pushd "$FOLDER" > /dev/null
	# Each pocket contains an independent Vina configuration
        if [ -f config.txt ]; then
	    # Run docking and save execution log
            vina --config config.txt --log "log_$FOLDER.txt"
        else
            echo "Warning: config.txt not found in $FOLDER"
        fi
        popd > /dev/null
    else
        echo "Directory $FOLDER not found, skipping..."
    fi
done
# Ensemble docking campaign completed
echo "Docking ensemble completed."
