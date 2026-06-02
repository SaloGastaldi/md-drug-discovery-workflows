#!/bin/bash
# Convierte archivos XVG a DAT limpios para graficar o procesar en Python
# Elimina encabezados (@ y #) y extrae columnas específicas.
# --------------------------------------------------------------------------------
# Typical use case:
# Prepares GROMACS outputs for downstream statistical analysis, plotting,
# machine learning workflows, or Python-based data processing.
# --------------------------------------------------------------------------------
for file in *.xvg; do
    [ -e "$file" ] || continue
    echo "Cleaning $file..."
    # Remove GROMACS metadata lines and keep only numerical data columns
    grep -v '^[#@]' "$file" | awk '{print $1, $4}' > "${file%.xvg}.dat"
done
