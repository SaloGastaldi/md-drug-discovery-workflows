# --------------------------------------------------------------------------------
# Script: interactive_geometry.tcl
# Description: Interactive tool to calculate and draw improper dihedrals 
# by picking 4 atoms on the VMD screen.
# Usage: Source this file and type 'enable_picking' in the console.
# --------------------------------------------------------------------------------

puts "------------------------------------------------------------"
puts "Interactive Dihedral Tool Loaded"
puts "1. Type 'enable_picking' to start."
puts "2. Press 'P' on the VMD display window."
puts "3. Click on 4 atoms to calculate the angle."
puts "4. Type 'disable_picking' to stop."
puts "------------------------------------------------------------"

global counter list_coord
set counter 0
set list_coord {}

proc enable_picking {} {
    global vmd_pick_event
    trace variable vmd_pick_event w calculate_four_atoms
    puts "Atom picking ENABLED."
}

proc disable_picking {} {
    global vmd_pick_event
    trace vdelete vmd_pick_event w calculate_four_atoms
    puts "Atom picking DISABLED."
}

proc calculate_four_atoms { args } {
    global vmd_pick_event vmd_pick_atom counter list_coord
    set pi 3.14159265
    
    set sel_at [atomselect top "index $vmd_pick_atom"]
    lappend list_coord [lindex [$sel_at get {x y z}] 0]
    set counter [incr counter]

    # Visual feedback: Label the picked atom
    draw color yellow
    draw text [lindex [$sel_at get {x y z}] 0] " [expr $vmd_pick_atom]"

    if {$counter == 1} {
        draw delete all
        draw color green
        draw text [lindex [$sel_at get {x y z}] 0] " [expr $vmd_pick_atom]"
    }

    if {$counter == 4} {
        set a1 [lindex $list_coord 0]
        set a2 [lindex $list_coord 1]
        set a3 [lindex $list_coord 2]
        set a4 [lindex $list_coord 3]

        set v12 [vecnorm [vecsub $a2 $a1]]
        set v13 [vecnorm [vecsub $a3 $a1]]
        set v23 [vecnorm [vecsub $a3 $a2]]
        set v24 [vecnorm [vecsub $a4 $a2]]

        set vN1 [vecnorm [veccross $v12 $v13]]
        set vN2 [vecnorm [veccross $v23 $v24]]

        set tita [expr acos([vecdot $vN1 $vN2])*180/$pi]
        
        # Result feedback on screen
        draw color magenta
        draw text [vecadd $a1 {1 1 1}] "[format "%5.2f" $tita] deg."
        puts "Calculated Dihedral Angle: $tita degrees"

        # Draw visual aid (Triangles)
        draw color yellow
        draw triangle $a1 $a2 $a3
        draw color red 
        draw triangle $a2 $a3 $a4
        
        # Reset for next measurement
        set counter 0
        set list_coord {}
    }
}
