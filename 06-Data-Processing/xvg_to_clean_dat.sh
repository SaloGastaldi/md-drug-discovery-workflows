#!/bin/bash
# Convierte archivos XVG a DAT limpios para graficar o procesar en Python
# Elimina encabezados (@ y #) y extrae columnas específicas.

for file in *.xvg; do
    [ -e "$file" ] || continue
    echo "Cleaning $file..."
    # Elimina líneas con @ o #, extrae columnas 1 y 4 (ajustable)
    grep -v '^[#@]' "$file" | awk '{print $1, $4}' > "${file%.xvg}.dat"
done
