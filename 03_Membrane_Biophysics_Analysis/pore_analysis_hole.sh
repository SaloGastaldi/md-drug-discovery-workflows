#!/bin/bash
# --------------------------------------------------------------------------------
# Script: pore_analysis_hole.sh
# Description: Automates pore radius analysis using HOLE across multiple
# trajectory snapshots and converts outputs into tabular formats.
# --------------------------------------------------------------------------------

for ns in {491..497}; do
    echo "Analizando frame: ${ns}ns"
    
    # Ejecutar HOLE si el archivo de entrada existe
    if [ -f "hole_${ns}ns.inp" ]; then
        hole < "hole_${ns}ns.inp" > "hole_out_${ns}ns.txt"
    fi

    # Extraer datos y convertir a CSV/DAT
    if [ -f "hole_out_${ns}ns.txt" ]; then
        egrep "mid-|sampled" "hole_out_${ns}ns.txt" > "hole_out_${ns}ns.tsv"
        # Convert pore radius to pore diameter for easier interpretation
        awk '{print $2*2, $1}' "hole_out_${ns}ns.tsv" > "diametro_${ns}ns.dat"
	# Export CSV-compatible format for plotting and downstream analysis
        sed 's/ \+/,/g' "diametro_${ns}ns.dat" > "diametro_${ns}ns.csv"
    fi
done
