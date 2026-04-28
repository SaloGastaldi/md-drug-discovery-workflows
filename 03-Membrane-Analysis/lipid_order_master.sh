#!/bin/bash
# --------------------------------------------------------------------------------
# Script: lipid_order_master.sh
# Description: Automated calculation of Deuterium Order Parameters (Scd) 
# for multiple topologies and equilibration times.
# --------------------------------------------------------------------------------

# 1. Configuration: Topologies to analyze
TOPOLOGIES=("topol_0.tpr" "topol_0_25.tpr" "topol_20_25.tpr" "topol_25_25.tpr")

# 2. Equilibration times (start time in ps)
START_TIMES=(100000 150000)

# 3. Chains (index files)
CHAINS=("sn1" "sn2")

echo "Starting Lipid Order Parameter Analysis..."

for TPR in "${TOPOLOGIES[@]}"; do
    if [ -f "$TPR" ]; then
        echo "--------------------------------------------------------"
        echo "Processing Topology: $TPR"
        
        # Clean name for output file (removes .tpr)
        BASE_NAME=$(basename "$TPR" .tpr)

        for TIME in "${START_TIMES[@]}"; do
            for CHAIN in "${CHAINS[@]}"; do
                
                # Format output filename: deuter_[chain]_[topol]_[time].xvg
                # Example: deuter_sn1_topol_20_25_150.xvg
                OUTPUT="deuter_${CHAIN}_${BASE_NAME}_$(expr $TIME / 1000).xvg"
                
                echo "  - Calculating $CHAIN at ${TIME}ps -> $OUTPUT"
                
                # Executing GROMACS order
                # 'echo' without arguments sends a newline (default selection)
                echo | gmx order -s "$TPR" -f trajout.xtc -n "${CHAIN}.ndx" \
                    -b "$TIME" -d z -od "$OUTPUT"
            done
        done
    else
        echo "Warning: $TPR not found. Skipping..."
    fi
done

echo "Analysis complete. Check your .xvg files."
