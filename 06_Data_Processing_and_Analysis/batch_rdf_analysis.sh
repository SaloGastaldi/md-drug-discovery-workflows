#!/bin/bash
# --------------------------------------------------------------------------------
# Script: batch_rdf_analysis.sh
# Description: Automated Radial Distribution Function (RDF) calculation 
# for multiple groups using GROMACS.
# --------------------------------------------------------------------------------

# --------------------------------------------------------------------------------
# Scientific context:
# RDF analysis quantifies spatial organization and preferential interactions
# between molecular species throughout MD trajectories.
# --------------------------------------------------------------------------------

# Parameters
TRAJ="chaps_12-1_MD.xtc"
TPR="chaps_12-1_MD.tpr"
INDEX="index_rdf.ndx"
START_TIME=30000

echo "Starting Batch RDF calculation..."

# Batch execution enables systematic comparison across multiple atom groups
# using a common reference selection.
for i in {0..4}; do

    # Group to analyze
    target_group=$((i + 6))
    
    echo "Calculating RDF for group 6 vs $target_group"
    
    # Generate:
    # - RDF profile (g(r))
    # - Coordination number profile
    echo 6 $target_group | g_rdf -f "$TRAJ" -s "$TPR" -n "$INDEX" \
        -o "rdf_${target_group}.xvg" \
        -cn "rdf_nc_${target_group}.xvg" \
        -b "$START_TIME" -dt 0.2 -rdf atom
done

echo "RDF analysis complete."
