# --------------------------------------------------------------------------------
# Script: residue_orientation_analyzer.tcl
# Description: Calculates the tilt angle (relative to Z) and the azimuthal 
# angle (phi, relative to X) for a specific residue vector over time.
# --------------------------------------------------------------------------------

# 1. Load System and Trajectory
mol new sim2.gro
mol addfile sim2.xtc first 5141 last 7140 step 1 waitfor all

# 2. Configuration
set resid_number 473
set atom_name1 "CB"
set atom_name2 "C22"
set PI 3.141592653589793

set num_steps [molinfo top get numframes]
set z_axis {0 0 1}
set x_axis {1 0 0}

# 3. Output Files
set res_all    [open "tilt_phi_combined.dat" w]
set res_tilt   [open "tilt_per_frame.dat" w]
set res_phi    [open "phi_per_frame.dat" w]

set tilt_list {}
set phi_list  {}

# 4. Analysis Loop
puts "Starting orientation analysis for Residue $resid_number ($atom_name1-$atom_name2)..."

for {set j 0} {$j < $num_steps} {incr j} {
    set sel1 [atomselect top "resid $resid_number and name $atom_name1" frame $j]
    set sel2 [atomselect top "resid $resid_number and name $atom_name2" frame $j]
    
    if {[$sel1 num] == 0 || [$sel2 num] == 0} { continue }

    set c1 [lindex [$sel1 get {x y z}] 0]
    set c2 [lindex [$sel2 get {x y z}] 0]
    
    # Vector PN (from atom2 to atom1)
    set vec_pn [vecsub $c1 $c2]
    set vec_norm [vecnorm $vec_pn]
    
    # --- Tilt Angle (Theta) ---
    # Angle relative to Z-axis
    set cos_theta [vecdot $vec_norm $z_axis]
    set tilt_rad  [expr acos($cos_theta)]
    set tilt_deg  [expr $tilt_rad * 180.0 / $PI]
    
    # --- Azimuthal Angle (Phi) ---
    # Projection on XY plane
    set dx [lindex $vec_pn 0]
    set dy [lindex $vec_pn 1]
    set phi_rad [expr atan2($dy, $dx)]
    set phi_deg [expr $phi_rad * 180.0 / $PI]
    if {$phi_deg < 0} { set phi_deg [expr $phi_deg + 360.0] }

    # Storage
    lappend tilt_list $tilt_deg
    lappend phi_list  $phi_deg
    
    puts $res_all  [format "%8.3f %8.3f" $tilt_deg $phi_deg]
    puts $res_tilt "$j [format "%8.3f" $tilt_deg]"
    puts $res_phi  "$j [format "%8.3f" $phi_deg]"

    $sel1 delete; $sel2 delete
}

# 5. Statistical Summary
proc calculate_stats {data_list label} {
    set sum 0.0
    set n [llength $data_list]
    foreach val $data_list { set sum [expr $sum + $val] }
    set avg [expr $sum / $n]
    
    set sq_diff 0.0
    foreach val $data_list { set sq_diff [expr $sq_diff + (($val - $avg)**2)] }
    set std [expr sqrt($sq_diff / $n)]
    
    puts "---------------------------------------"
    puts "$label - Average: [format %.3f $avg] | StdDev: [format %.3f $std]"
    return [list $avg $std]
}

calculate_stats $tilt_list "TILT"
calculate_stats $phi_list "PHI"

close $res_all; close $res_tilt; close $res_phi
puts "Analysis complete."
