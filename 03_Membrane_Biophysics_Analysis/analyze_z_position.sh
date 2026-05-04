#!/bin/bash
# Calcula la posición COM en el eje Z a lo largo del tiempo para diferentes grupos.
# Grupos sugeridos: Upper Leaflet (27), Lower Leaflet (28), Ligand (13).

TRAJ="md_150-500ns_corta.xtc"
TPR="md_100-150ns.tpr"
INDEX="z_index.ndx"

# Upper leaflet COM
echo 27 | gmx_mpi traj -f $TRAJ -s $TPR -n $INDEX -ox z_upper.xvg -tu ns -pbc -z -com -nox -noy -xvg none

# Lower leaflet COM
echo 28 | gmx_mpi traj -f $TRAJ -s $TPR -n $INDEX -ox z_lower.xvg -tu ns -pbc -z -com -nox -noy -xvg none

# Ligand COM
echo 13 | gmx_mpi traj -f $TRAJ -s $TPR -n $INDEX -ox z_ligand.xvg -tu ns -pbc -z -com -nox -noy -xvg none
