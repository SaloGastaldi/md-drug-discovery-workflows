#!/bin/bash
# --------------------------------------------------------------------------------
# Script: analyze_z_position.sh
# Description: Tracks the center-of-mass position of membrane leaflets and
# ligands along the membrane normal (Z-axis) throughout the simulation.
# Useful for monitoring insertion depth and translocation events.
# --------------------------------------------------------------------------------
TRAJ="md_150-500ns_corta.xtc"
TPR="md_100-150ns.tpr"
INDEX="z_index.ndx"

# Upper leaflet center-of-mass trajectory
echo 27 | gmx_mpi traj -f $TRAJ -s $TPR -n $INDEX -ox z_upper.xvg -tu ns -pbc -z -com -nox -noy -xvg none

# Lower leaflet center-of-mass trajectory
echo 28 | gmx_mpi traj -f $TRAJ -s $TPR -n $INDEX -ox z_lower.xvg -tu ns -pbc -z -com -nox -noy -xvg none

# Ligand center-of-mass trajectory
echo 13 | gmx_mpi traj -f $TRAJ -s $TPR -n $INDEX -ox z_ligand.xvg -tu ns -pbc -z -com -nox -noy -xvg none
