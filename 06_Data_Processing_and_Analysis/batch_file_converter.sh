#!/bin/bash
# --------------------------------------------------------------------------------
# Script: batch_file_converter.sh
# Description: Converts all .dat files to .xvg format for GROMACS compatibility.
# --------------------------------------------------------------------------------

# Iterate directly through the files in the directory
for file in *.dat; do
    # Check if files exist to avoid errors in empty folders
    [ -e "$file" ] || continue
    
    # Create a copy with the new extension
    cp "$file" "${file}.xvg"
    echo "Converted: $file -> ${file}.xvg"
done

echo "All files processed."
