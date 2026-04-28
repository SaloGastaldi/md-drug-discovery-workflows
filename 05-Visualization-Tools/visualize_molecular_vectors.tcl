# --------------------------------------------------------------------------------
# Script: visualize_molecular_vectors.tcl
# Description: Draws a 3D arrow representing the molecular normal vector 
# and a reference Z-axis in VMD. Useful for verifying tilt angle calculations.
# --------------------------------------------------------------------------------

proc draw_orientation_vectors {resid_id} {
    # 1. Selection of key atoms for the Spin Label (SLX)
    set sel_c12 [atomselect top "resid $resid_id and name C12"]
    set sel_cb  [atomselect top "resid $resid_id and name CB"]
    set sel_oh  [atomselect top "resid $resid_id and name OH1"]
    set sel_nr5 [atomselect top "resid $resid_id and name NR5"]

    # Check if all atoms exist to avoid errors
    if {[$sel_c12 num] == 0} { puts "Error: Residue $resid_id not found."; return }

    set c12 [lindex [$sel_c12 get {x y z}] 0]
    set cb  [lindex [$sel_cb get {x y z}] 0]
    set oh  [lindex [$sel_oh get {x y z}] 0]
    set nr5 [lindex [$sel_nr5 get {x y z}] 0]

    # 2. Vector Math: Calculating the Normal to the ring
    set v1 [vecsub $cb $c12]
    set v2 [vecsub $oh $c12]
    
    # Cross product gives the normal vector (perpendicular to the ring plane)
    set v_norm [vecnorm [veccross $v2 $v1]]
    
    # Scaling for visualization (Length = 5 Angstroms)
    set v_final [vecscale $v_norm 5.0]
    set v_head  [vecadd [vecscale $v_final 0.9] $nr5]
    set v_end   [vecadd $v_final $nr5]

    # 3. Drawing the Molecular Normal Vector (RED)
    draw delete all ;# Clean previous drawings
    draw color red
    draw cylinder $nr5 $v_head radius 0.15 resolution 30
    draw cone $v_head $v_end radius 0.4 resolution 30

    # 4. Drawing the Reference Z-axis (GREEN)
    set z_ref {0 0 5}
    set z_head [vecadd [vecscale $z_ref 0.9] $nr5]
    set z_end  [vecadd $z_ref $nr5]

    draw color green
    draw cylinder $nr5 $z_head radius 0.15 resolution 30
    draw cone $z_head $z_end radius 0.4 resolution 30
    
    # Cleanup selections
    foreach s {sel_c12 sel_cb sel_oh sel_nr5} { $s delete }
    
    puts "Vectors drawn for residue $resid_id: Red (Normal), Green (Z-axis reference)"
}

# Usage in VMD console:
# source visualize_molecular_vectors.tcl
# draw_orientation_vectors 142
