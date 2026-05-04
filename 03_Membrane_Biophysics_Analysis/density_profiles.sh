#!/bin/bash
# Script para calcular perfiles de densidad de diferentes componentes del sistema
# Grupos: 0=DOPC, 2=PNP2, 3=Water, 4=Choline, 5=Phosphate, 6=Glycerol, 7=Hyd_chain

GROUPS=(0 2 3 4 5 6 7)
NAMES=("DOPC" "PNP2" "SOL" "Choline" "Phosphate" "Glycerol" "Hyd_chain")

for i in "${!GROUPS[@]}"; do
    echo "Calculando densidad para: ${NAMES[$i]}"
    echo "${GROUPS[$i]}" | gmx density -f md.xtc -n index-dens.ndx -s md.tpr -b 100000 -o "density-${NAMES[$i]}-100.xvg" -sl 200
done

