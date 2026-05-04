#!/bin/bash
# --------------------------------------------------------------------------------
# Script: hbond_master_analysis.sh
# Description: Systematic Hydrogen Bond analysis for Fluralaner (FLU) interaction
# with DPPC membranes and Water. Supports multiple topologies and trajectories.
# --------------------------------------------------------------------------------

# 1. Configuration: Define analysis sets (Topology | Trajectory | Label)
# Format: "TPR_FILE|XTC_FILE|SUFFIX"
SETS=(
    "topol_0_25.tpr|trajout.xtc|Set0"
    "DPPC-FLU_surf_tens_10.tpr|DPPC-FLU_surf_tens_10_posta.xtc|SurfTens10"
    "topol_40_25.tpr|trajout.xtc|Set40"
)

# 2. Functional Groups Mapping (Based on your Index file)
# Pair: "GroupIDs:Description"
PAIRS=(
    "3 2:FLU_DPPC"
    "3 7:FLU_DPPC_phosphate"
    "3 8:FLU_DPPC_glycerol"
    "3 5:FLU_Water"
    "9 2:FLU_amide_DPPC"
    "9 7:FLU_amide_DPPC_phosphate"
    "9 8:FLU_amide_DPPC_glycerol"
    "9 5:FLU_amide_Water"
)

echo "Starting Hydrogen Bond Systematic Analysis..."

for SET in "${SETS[@]}"; do
    IFS="|" read -r TPR XTC SUFFIX <<< "$SET"
    
    if [[ -f "$TPR" && -f "$XTC" ]]; then
        echo "--------------------------------------------------------"
        echo "Processing Set: $SUFFIX ($TPR)"
        echo "--------------------------------------------------------"

        for PAIR_INFO in "${PAIRS[@]}"; do
            IDS=${PAIR_INFO%%:*}
            DESC=${PAIR_INFO#*:}
            OUTPUT_NAME="${DESC}_${SUFFIX}"

            echo "Analyzing $DESC..."
            
            # Executing GROMACS hbond
            echo $IDS | gmx hbond -f "$XTC" -s "$TPR" -n HBond.ndx \
                -num "${OUTPUT_NAME}.xvg" \
                -dist "${OUTPUT_NAME}_dist.xvg" \
                -hbn "${OUTPUT_NAME}_index.ndx" \
                -b 100000
        done
    else
        echo "Warning: Files for $SUFFIX not found. Skipping..."
    fi
done

echo "Full analysis complete."
