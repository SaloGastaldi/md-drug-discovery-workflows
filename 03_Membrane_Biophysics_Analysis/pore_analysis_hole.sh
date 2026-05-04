#!/bin/bash
# Automatización del análisis de poros con HOLE (491ns a 497ns)

for ns in {491..497}; do
    echo "Analizando frame: ${ns}ns"
    
    # Ejecutar HOLE si el archivo de entrada existe
    if [ -f "hole_${ns}ns.inp" ]; then
        hole < "hole_${ns}ns.inp" > "hole_out_${ns}ns.txt"
    fi

    # Extraer datos y convertir a CSV/DAT
    if [ -f "hole_out_${ns}ns.txt" ]; then
        egrep "mid-|sampled" "hole_out_${ns}ns.txt" > "hole_out_${ns}ns.tsv"
        # Convertir radio a diámetro ($2*2) y formatear
        awk '{print $2*2, $1}' "hole_out_${ns}ns.tsv" > "diametro_${ns}ns.dat"
        sed 's/ \+/,/g' "diametro_${ns}ns.dat" > "diametro_${ns}ns.csv"
    fi
done
