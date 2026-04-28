#!/bin/bash
# --------------------------------------------------------------------------------
# Script: batch_rdf_analysis.sh
# Description: Automated Radial Distribution Function (RDF) calculation 
# for multiple groups using GROMACS.
# --------------------------------------------------------------------------------

# Parameters
TRAJ="chaps_12-1_MD.xtc"
TPR="chaps_12-1_MD.tpr"
INDEX="index_rdf.ndx"
START_TIME=30000

echo "Starting Batch RDF calculation..."

# Loop through groups (assuming group 6 as reference)
for i in {0..4}; do
    # Group to analyze
    target_group=$((i + 6))
    
    echo "Calculating RDF for group 6 vs $target_group"
    
    # Executing g_rdf (standard GROMACS command)
    # 6 is the reference group, $target_group is the target
    echo 6 $target_group | g_rdf -f "$TRAJ" -s "$TPR" -n "$INDEX" \
        -o "rdf_${target_group}.xvg" \
        -cn "rdf_nc_${target_group}.xvg" \
        -b "$START_TIME" -dt 0.2 -rdf atom
done

echo "RDF analysis complete."
