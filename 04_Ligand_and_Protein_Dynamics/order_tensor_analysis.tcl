# --------------------------------------------------------------------------------
# Script: order_tensor_analysis.tcl
# Description: Calculates the Orientation Order Tensor and Principal Axes
# for a specific molecular moiety (e.g., doxyl ring in SL05).
# Includes diagonalization of the matrix using the 'La' package.
# --------------------------------------------------------------------------------

package require La

# 1. Load Molecular System
mol new SL05_marcadorsolo.gro
mol addfile SL05_marcadorsolo.xtc first 0 waitfor all

# 2. Configuration & Initialization
set PI 3.14159265359
set num_steps [molinfo top get numframes]
set theta_max 180.0
set N_interval 180 

# Initialize V matrix (Order Tensor)
for {set m 1} {$m <= 3} {incr m} {
    for {set n 1} {$n <= 3} {incr n} {
        set V($m,$n) 0.0
    }
}

# 3. Setup Output Files
set fid_norm [open "Normal_Vector_Components.dat" w]
set fid_up   [open "Angle_Distribution_Up.dat" w]
set fid_down [open "Angle_Distribution_Down.dat" w]

# 4. Atom Selection
# Selecting the ring atoms to define the normal vector (C5, CB, OH1)
set sel_all [atomselect top "all"]
set sel_ring [atomselect top "resname SL05 and name C5 CB OH1"]

puts "Analyzing orientation for: [$sel_ring get name]"

# 5. Loop over Trajectory
for {set frame 0} {$frame < $num_steps} {incr frame} {
    $sel_all frame $frame
    $sel_all update
    $sel_ring frame $frame
    $sel_ring update

    # Calculate Normal Vector to the ring plane
    set coords [$sel_ring get {x y z}]
    set vec1 [vecsub [lindex $coords 0] [lindex $coords 1]]
    set vec2 [vecsub [lindex $coords 2] [lindex $coords 1]]
    
    set norm_v [vecnorm [veccross $vec1 $vec2]]
    set Normal($frame) $norm_v
    
    # Write components (Frame, Nx, Ny, Nz)
    puts $fid_norm [format "%d %.10f %.10f %.10f" $frame [lindex $norm_v 0] [lindex $norm_v 1] [lindex $norm_v 2]]

    # Accumulate Order Tensor Matrix elements: V_ij = 1.5*(n_i * n_j) - 0.5*delta_ij
    set Nx [lindex $norm_v 0]; set Ny [lindex $norm_v 1]; set Nz [lindex $norm_v 2]
    
    set V(1,1) [expr $V(1,1) + 1.5*($Nx*$Nx)-0.5]
    set V(1,2) [expr $V(1,2) + 1.5*($Nx*$Ny)]
    set V(1,3) [expr $V(1,3) + 1.5*($Nx*$Nz)]
    
    set V(2,1) [expr $V(2,1) + 1.5*($Ny*$Nx)]
    set V(2,2) [expr $V(2,2) + 1.5*($Ny*$Ny)-0.5]
    set V(2,3) [expr $V(2,3) + 1.5*($Ny*$Nz)]
    
    set V(3,1) [expr $V(3,1) + 1.5*($Nz*$Nx)]
    set V(3,2) [expr $V(3,2) + 1.5*($Nz*$Ny)]
    set V(3,3) [expr $V(3,3) + 1.5*($Nz*$Nz)-0.5]
}

# 6. Averaging and Diagonalization
# [... el script continúa con el cálculo de autovalores y autovectores usando La::mevsvd_br ...]

close $fid_norm
close $fid_up
close $fid_down
puts "Order Tensor Analysis Complete."
if {$H2 == 0} {; #checking whether lista2 exists
  set lista2 [lsort -real -increasing -index 0 $lista2]
  foreach b $lista2 {
    puts $fid3 $b
  }
}
#########################################################################################

#building theta histogram
set counter_hist_point 0;#counter of point in histogram
set int_size [expr $theta_max / $N_interval]; #interval size in degrees
for {set i 1} {$i <= $num_steps} {incr i} {
  set counter_hist_point [expr $counter_hist_point + 1]
  set theta_deg [expr $theta($i) * 180.0 / $PI]
  set j [expr int(floor($theta_deg / $int_size))]
  #puts "theta_max: [expr $theta_max + 180/$PI] // theta_deg: $theta_deg // int_size: $int_size // distr_slice: $j"
  set theta_d($j) [expr $theta_d($j) + 1]
}
#writing theta histogram 
for {set i 1} {$i < $N_interval} {incr i} {
  set theta_d_Normal [expr 1.0 * $theta_d($i) / ($counter_hist_point * $int_size)]
  set theta_d_Normal2 [expr 1.0 * $theta_d($i) / (2 * $PI * sin($int_size*$i*$PI/180.0)* $num_steps)]
  puts "sin([expr $int_size*$i]) --> [expr sin($int_size*$i)] ## counter_hist: $num_steps"
  puts "--> [format %8.6f [expr $i*$int_size]] [format %19.8f $theta_d_Normal]"
  puts $fid5 "[format %8.6f [expr $i*$int_size]] [format %10.8f $theta_d_Normal]"
  puts $fid7 "[format %8.6f [expr $i*$int_size]] [format %10.8f $theta_d_Normal2]"  
}

close $fid2
close $fid3
close $fid6
close $fid5
close $fid7

#writing ACF fortran file
set fid9 [open ACF.f w]
puts $fid9 "	program ACF"
puts $fid9 "	IMPLICIT none"
puts $fid9 "	integer :: i, j , l, k, m"
puts $fid9 "	real :: A($num_steps, 3), scalar"
puts $fid9 "	real :: P1, P2"
puts $fid9 "	real :: PI"
puts $fid9 "	PI = acos(-1.0)"
puts $fid9 "	open(unit = 1, file = \"$fileout\", STATUS='OLD')"
puts $fid9 "	open(unit = 2, file = \"ACF_V_2.dat\")"
puts $fid9 "c   	Read values"
puts $fid9 "	do i = 1, $num_steps"
puts $fid9 "		read(1, *) l, ( A(i, j), j=1, 3 )"
puts $fid9 "       enddo"
puts $fid9 "	close(1)"
puts $fid9 "c   	ACF calc"
puts $fid9 "	do i = 0, [expr $num_steps / 2]"
puts $fid9 "	P1= 0.0"
puts $fid9 "	P2= 0.0"
puts $fid9 "       m = $num_steps - i"
puts $fid9 "	  do j = 1, m"
puts $fid9 "	  k = i + j"
puts $fid9 "	  scalar = A(j, 1)*A(k, 1) +  A(j, 2)*A(k, 2) + A(j, 3)*A(k, 3)"
puts $fid9 "  	  P1 = P1 + scalar"
puts $fid9 "	  P2 = P2 + ((3*(scalar)**(2) - 1) / 2)"
puts $fid9 "	  enddo"
puts $fid9 "	  P1 = P1 / m"
puts $fid9 "	  P2 = P2 / m"
puts $fid9 "	  write(2,*) i, P1, P2"
puts $fid9 "       enddo"
puts $fid9 "       close(2)"
puts $fid9 "       end program ACF"
close $fid9

exec chmod 777 ACF.f
puts "compiling .."
exec gfortran -o acf ACF.f
puts "#################"
puts "running ACF calc."
exec ./acf

#Angle between Normal and Z axis
puts "ANGLE BETWEEN VPRINC AND Z: [format %8.3f [expr acos([vecdot {0 0 1} $V_Princ])*180/3.1416]]"
puts "ANGLE BETWEEN VPRINC AND X; [format %8.3f [expr atan2($VP_y,$VP_x)*180/3.1416]]"
exit
#} 


