# --------------------------------------------------------------------------------
# Script: lipid_spin_label_order_params.tcl
# Description: Advanced calculation of Order Parameters for n-SASL acyl chains.
# Computes dual order tensors for both the acyl chain segments and the 
# attached nitroxide ring normal vector.
# --------------------------------------------------------------------------------

package require La

# 1. Loading Trajectory
mol new SL05_marcadorsolo.gro
mol addfile SL05_marcadorsolo.xtc first 1 last 150000 step 1 waitfor all

# 2. Setup Parameters
set res_start 1; set res_end 1
set t_ns 4       ;# Time window size in ns
set t_final 150  ;# Total trajectory time
set PI 3.14159265359

set outfile  [open "AcylChain_OrderTensor.dat" w]
set outfile2 [open "RingNormal_OrderTensor.dat" w]

# Defining the acyl chain segment (e.g., C4-C5-C6)
set list_C {C4 C5 C6}
set N_frag [expr [llength $list_C] - 2]
set Natoms [llength $list_C]

# Helper lists for vector geometry (Ci-1, Ci, Ci+1)
set list_Cprev [lreplace $list_C end-1 end]
set list_Cpost [lreplace $list_C 0 1]
set list_Ci    [lrange $list_C 1 end-1]

# 3. Matrix Initialization Function
proc init_tensor_array {name size} {
    upvar $name T
    for {set m 1} {$m<=3} {incr m} {
        for {set n 1} {$n<=3} {incr n} {
            for {set o 1} {$o <= $size} {incr o} { set T($m,$n,$o) 0.0 }
        }
    }
}

init_tensor_array Pavg $N_frag
init_tensor_array P2avg $N_frag

# 4. Main Interval Loop (Temporal segmentation)
for {set t_start 0} {$t_start < $t_final} {incr t_start $t_ns} {
    puts "Processing Interval: $t_start to [expr $t_start + $t_ns] ns"
    init_tensor_array P $N_frag
    init_tensor_array P2 $N_frag

    # Loop over frames in the interval
    set frame_start [expr $t_start * 1000]
    set frame_end   [expr ($t_start + $t_ns) * 1000]
    
    for {set j $frame_start} {$j <= $frame_end} {incr j} {
        set M 0
        foreach c1 $list_Cprev c2 $list_Cpost c3 $list_Ci {
            incr M
            # Selections for Acyl Chain and Ring atoms
            set s1 [atomselect top "residue $res_start and name $c1" frame $j]
            set s2 [atomselect top "residue $res_start and name $c2" frame $j]
            set s3 [atomselect top "residue $res_start and name $c3" frame $j]
            set sR [atomselect top "residue $res_start and name OH1 CB NR5" frame $j]
            
            set coords_chain [list [$s1 get {x y z}] [$s2 get {x y z}] [$s3 get {x y z}]]
            set coords_ring  [$sR get {x y z}]
            
            # --- Acyl Chain Local Frame Calculation ---
            set a [lindex $coords_chain 0 0]; set b [lindex $coords_chain 1 0]; set c [lindex $coords_chain 2 0]
            set z_loc [vecnorm [vecsub $a $b]]
            set y_loc [vecnorm [vecadd [vecsub $a $c] [vecinvert [vecsub $c $b]]]]
            set x_loc [vecnorm [veccross $z_loc $y_loc]]

            # --- Ring Normal Calculation ---
            # Using OH1 (d), CB (e), NR5 (f)
            set d [lindex $coords_ring 0]; set e [lindex $coords_ring 1]; set f [lindex $coords_ring 2]
            set v_oh_nr5 [vecnorm [vecsub $d $f]]
            set v_cb_nr5 [vecnorm [vecsub $e $f]]
            set nz_ring [vecnorm [veccross $v_oh_nr5 $v_cb_nr5]]
            set nx_ring $v_oh_nr5
            set ny_ring [veccross $nz_ring $nx_ring]

            # Projecting onto Global Z axis
            set comp_chain [list [vecdot {0 0 1} $x_loc] [vecdot {0 0 1} $y_loc] [vecdot {0 0 1} $z_loc]]
            set comp_ring  [list [vecdot {0 0 1} $nx_ring] [vecdot {0 0 1} $ny_ring] [vecdot {0 0 1} $nz_ring]]

            # Update Tensors (Chain P and Ring P2)
            # [Lógica de acumulación de matriz V_ij = 1.5*ni*nj - 0.5*delta_ij omitida por brevedad, similar a scripts anteriores]
            
            $s1 delete; $s2 delete; $s3 delete; $sR delete
        }
    }
    # Diagonalization and output logic per interval...
}

close $outfile; close $outfile2

