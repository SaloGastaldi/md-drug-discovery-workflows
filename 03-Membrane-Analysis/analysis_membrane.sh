#!/bin/bash
# --------------------------------------------------------------------------------
# Script: analysis_membrane.sh
# Description: Automated post-processing for MD membrane simulations (GROMACS).
# Analyzes density, membrane width, tilt angles (PNP), and order parameters.
# --------------------------------------------------------------------------------

# 1. DENSITY PROFILE
# Groups: 0 2 3 10 11 12 13 (Modify based on your index file)
echo "Calculating density profile..."
echo 0 2 3 10 11 12 13 | gmx density -f trajout.xtc -n index-dens.ndx -s md.tpr -b 100000 -o density-all-100.xvg -sl 200 -ng 7

# 2. MEMBRANE THICKNESS & POSITION
# Extracting COM coordinates for specific groups to calculate width
echo "Calculating membrane thickness..."
echo 0 8 9 3 10 11 | gmx traj -f trajout.xtc -s md.tpr -n index.ndx -ng 4 -ox coord.xvg -tu ns -pbc -z -com -nox -noy -xvg none

# AWK processing: $2=center, $3=upper, $4=lower, $5=sulfur
awk '{centro = $2 - $2; arriba = $3 - $2; abajo = $4 - $2; width = $3 - $4; print $1, centro, arriba, abajo, width}' coord.xvg > membrane_stats.dat
rm coord.xvg

# 3. ORIENTATION ANALYSIS (PNP TILT)
# Calculates the angle between the PNP vector and the Z-axis (membrane normal)
if [ -f angle.ndx ]; then
    echo "Analyzing PNP orientation..."
    gmx gangle -f trajout.xtc -s md.tpr -n angle.ndx -g1 vector -g2 z -oh eje.xvg -binw 10
fi

# 4. ORDER PARAMETERS (SCD)
# Calculating deuterium order parameters for lipid tails (last 100ns)
echo "Calculating order parameters (Scd)..."
gmx order -s md.tpr -f trajout.xtc -n sn1.ndx -b 100000 -d z -od deuter_sn1-100.xvg

echo "Analysis complete. Data saved in .dat and .xvg files."
