# --------------------------------------------------------------------------------
# Script: membrane_thickness_analyzer.tcl
# Description: Calculates the average bilayer thickness over a trajectory
# by measuring the distance between the center of mass of reference atoms 
# (e.g., Phosphorus P8) in the upper and lower leaflets.
# --------------------------------------------------------------------------------

package require pbctools

# 1. Load System and Trajectory
mol new LC_16dyn_250-300ns_pbcmol_final.gro
mol addfile md.xtc first 0 last 25000 step 10 waitfor all

set fileout [open "thickness_analysis.dat" w]
puts $fileout "# Frame | Thickness (A)"

# 2. Setup Reference Parameters
set atName "P8"
set num_steps [molinfo top get numframes]

# Get initial box dimensions to define leaflets
set box [pbc get]
set Zbox [lindex $box 0 2]
set Zcenter [expr $Zbox / 2.0]

# Define safety margins to avoid picking atoms in the 'wrong' leaflet 
# during initial selection (approx. 15% from the center)
set Z1 [expr $Zcenter * 0.85]
set Z2 [expr $Zcenter * 1.15]

# 3. Identify Leaflets (Initial Frame)
set sel_P_up_init   [atomselect top "name $atName and z < $Z1"]
set sel_P_down_init [atomselect top "name $atName and z > $Z2"]

set list_P_up   [$sel_P_up_init get resid]
set list_P_down [$sel_P_down_init get resid]

if {[llength $list_P_up] != [llength $list_P_down]} {
    puts "Warning: Asymmetric number of atoms detected between leaflets."
}

# 4. Final Selections for Calculation
set sel_up   [atomselect top "name $atName and resid $list_P_up"]
set sel_down [atomselect top "name $atName and resid $list_P_down"]

set list_thickness {}

# 5. Analysis Loop
for {set frame 0} {$frame < $num_steps} {incr frame} {
    $sel_up frame $frame
    $sel_up update
    $sel_down frame $frame
    $sel_down update

    # Calculate average Z for each leaflet
    set z_up   [$sel_up get z]
    set z_down [$sel_down get z]
    
    set sum_up 0.0; set sum_down 0.0
    foreach z $z_up { set sum_up [expr $sum_up + $z] }
    foreach z $z_down { set sum_down [expr $sum_down + $z] }
    
    set avg_up   [expr $sum_up / [llength $z_up]]
    set avg_down [expr $sum_down / [llength $z_down]]
    
    set current_thickness [expr $avg_down - $avg_up]
    lappend list_thickness $current_thickness
    
    puts $fileout "$frame [format %8.4f $current_thickness]"
    puts "Frame $frame: Thickness = [format %8.4f $current_thickness] A"
}

# 6. Statistical Summary
set total_t 0.0
foreach t $list_thickness { set total_t [expr $total_t + $t] }
set avg_t [expr $total_t / [llength $list_thickness]]

set sq_diff 0.0
foreach t $list_thickness {
    set sq_diff [expr $sq_diff + (($t - $avg_t)**2)]
}
set std_t [expr sqrt($sq_diff / [llength $list_thickness])]

puts "---------------------------------------"
puts "Average Thickness: [format %.4f $avg_t] A"
puts "Standard Deviation: [format %.4f $std_t] A"
puts "---------------------------------------"

close $fileout
