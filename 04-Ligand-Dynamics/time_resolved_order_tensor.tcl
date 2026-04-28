# --------------------------------------------------------------------------------
# Script: time_resolved_order_tensor.tcl
# Description: Calculates time-resolved Order Tensor and angular dispersion
# using a sliding window (delta_t) approach. 
# Analyzes the tilt (theta) and azimuth (phi) of molecular moieties.
# --------------------------------------------------------------------------------

package require La

# 1. System Setup
mol new SL05_marcadorsolo.gro
mol addfile SL05_marcadorsolo.xtc first 10000 last 12000 waitfor all

# 2. Configuration
set PI 3.14159265359
set num_frames [molinfo top get numframes]
set delta_t 20 ;# Window size (e.g., 20 frames = 200 ps if 10ps/frame)
set Z_marker {0 0 -1} ;# Reference vector (Down-leaflet convention)

set fileout [open "Time_Resolved_Orientation.dat" w]
puts $fileout "# Time(ps) | Theta(deg) | Phi(deg) | Std_Dev(deg)"

# 3. Atom Selection
set sel_ring [atomselect top "resname SL52 and name C5 CB OH1"]

# 4. Main Windowing Loop
set num_intervals [expr int(floor($num_frames / $delta_t))]
puts "Starting analysis over $num_intervals time windows..."

for {set j 0} {$j < $num_intervals} {incr j} {
    set frame_start [expr $j * $delta_t]
    set frame_end [expr ($j + 1) * $delta_t - 1]
    
    # Initialize Matrix V (Order Tensor)
    for {set m 1} {$m <= 3} {incr m} {
        for {set n 1} {$n <= 3} {incr n} { set V($m,$n) 0.0 }
    }

    set norm_sum {0.0 0.0 0.0}

    # Internal Loop: Processing frames within the current window
    for {set f $frame_start} {$f <= $frame_end} {incr f} {
        $sel_ring frame $f
        $sel_ring update
        
        set coords [$sel_ring get {x y z}]
        set v1 [vecsub [lindex $coords 0] [lindex $coords 1]]
        set v2 [vecsub [lindex $coords 2] [lindex $coords 1]]
        set n_v [vecnorm [veccross $v1 $v2]]
        
        set Normal($f) $n_v
        set norm_sum [vecadd $norm_sum $n_v]

        # Accumulate Tensor components
        set Nx [lindex $n_v 0]; set Ny [lindex $n_v 1]; set Nz [lindex $n_v 2]
        set V(1,1) [expr $V(1,1) + 1.5*($Nx*$Nx)-0.5]
        set V(1,2) [expr $V(1,2) + 1.5*($Nx*$Ny)]
        set V(1,3) [expr $V(1,3) + 1.5*($Nx*$Nz)]
        set V(2,2) [expr $V(2,2) + 1.5*($Ny*$Ny)-0.5]
        set V(2,3) [expr $V(2,3) + 1.5*($Ny*$Nz)]
        set V(3,3) [expr $V(3,3) + 1.5*($Nz*$Nz)-0.5]
    }
    # (Symmetry: V_ij = V_ji)
    set V(2,1) $V(1,2); set V(3,1) $V(1,3); set V(3,2) $V(2,3)

    # 5. Average and Diagonalize
    set norm_avg [vecscale [expr 1.0/$delta_t] $norm_sum]
    set matrix "2 3 3 [expr $V(1,1)/$delta_t] [expr $V(1,2)/$delta_t] [expr $V(1,3)/$delta_t] \
                      [expr $V(2,1)/$delta_t] [expr $V(2,2)/$delta_t] [expr $V(2,3)/$delta_t] \
                      [expr $V(3,1)/$delta_t] [expr $V(3,2)/$delta_t] [expr $V(3,3)/$delta_t]"
    
    La::mevsvd_br matrix evals
    
    # Extract Principal Vector (V_Princ)
    set V_Princ [vecnorm [list [lindex $matrix 3] [lindex $matrix 4] [lindex $matrix 5]]]
    
    # Correct inversion (keep consistency with average orientation)
    if {[vecdot $V_Princ $norm_avg] < 0.0} { set V_Princ [vecscale -1.0 $V_Princ] }

    # 6. Dispersion and Final Metrics
    set sum_sq_theta 0.0
    foreach f_idx [array names Normal] {
        if {$f_idx >= $frame_start && $f_idx <= $frame_end} {
            set dev [expr acos([vecdot $Normal($f_idx) $V_Princ]) * 180.0 / $PI]
            set sum_sq_theta [expr $sum_sq_theta + ($dev**2)]
        }
    }
    
    set theta_std [expr sqrt($sum_sq_theta / $delta_t)]
    set theta_v [expr acos([vecdot $Z_marker $V_Princ]) * 180.0 / $PI]
    set phi_v   [expr atan2([lindex $V_Princ 0], [lindex $V_Princ 1]) * 180.0 / $PI]

    # Write Results
    puts $fileout "[format "%8.2f" [expr ($j+1)*$delta_t]] [format "%8.3f" $theta_v] [format "%8.3f" $phi_v] [format "%8.3f" $theta_std]"
}

close $fileout
puts "Time-resolved analysis finished."

