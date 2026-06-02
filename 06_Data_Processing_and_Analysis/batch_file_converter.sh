#!/bin/bash
# --------------------------------------------------------------------------------
# Script: batch_file_converter.sh
# Description: Converts all .dat files to .xvg format for GROMACS compatibility.
# --------------------------------------------------------------------------------
# Typical use case:
# Standardizes simulation outputs by converting custom .dat files into .xvg
# extensions compatible with GROMACS-oriented visualization workflows.
# --------------------------------------------------------------------------------

# Iterate directly through the files in the directory
for file in *.dat; do
    # Check if files exist to avoid errors in empty folders
    [ -e "$file" ] || continue
    
    # Preserve original file while generating a GROMACS-compatible copy
    cp "$file" "${file}.xvg"
    echo "Converted: $file -> ${file}.xvg"
done

echo "All files processed."
