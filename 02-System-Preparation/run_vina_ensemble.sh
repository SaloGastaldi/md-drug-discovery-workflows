#!/bin/bash
# --------------------------------------------------------------------------------
# Script: run_vina_ensemble.sh
# Description: Automates Autodock Vina execution across multiple protein pockets
# (TM1-A_TM3-E, etc.). Standard workflow for GABAA receptor docking.
# --------------------------------------------------------------------------------

# List of target subdirectories
POCKETS=("TM1-A_TM3-E" "TM1-B_TM3-A" "TM1-C_TM3-B" "TM1-D_TM3-C" "TM1-E_TM3-D")

for FOLDER in "${POCKETS[@]}"; do
    if [ -d "$FOLDER" ]; then
        echo "Processing pocket: $FOLDER"
        
        # Copying ligands to target folder (Assuming .pdbqt files are in current dir)
        cp *.pdbqt "$FOLDER/"
        
        # Entering folder and running Vina
        pushd "$FOLDER" > /dev/null
        if [ -f config.txt ]; then
            vina --config config.txt --log "log_$FOLDER.txt"
        else
            echo "Warning: config.txt not found in $FOLDER"
        fi
        popd > /dev/null
    else
        echo "Directory $FOLDER not found, skipping..."
    fi
done

echo "Docking ensemble completed."
