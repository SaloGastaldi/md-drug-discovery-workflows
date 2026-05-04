# --------------------------------------------------------------------------------
# Script: draw_membrane_planes.tcl
# Description: Visual aid tool for VMD. Draws translucent or opaque planes 
# at specific Z coordinates to represent membrane boundaries.
# --------------------------------------------------------------------------------

proc draw_plane {x_dim y_dim z_pos color} {
    # Set material properties for a professional look
    draw materials on
    draw material Transparent ;# Recommended for membrane representation
    draw color $color

    # Drawing the plane using two triangles to form a rectangle
    # Vertex coordinates:
    set p1 [list 0      0      $z_pos]
    set p2 [list $x_dim 0      $z_pos]
    set p3 [list 0      $y_dim $z_pos]
    set p4 [list $x_dim $y_dim $z_pos]

    draw triangle $p1 $p2 $p3
    draw triangle $p2 $p3 $p4
    
    puts "Plane drawn at Z = $z_pos with color $color"
}

# Example usage:
# draw_plane 80 80 42 "blue"  ;# Upper leaflet boundary
# draw_plane 80 80 15 "red"   ;# Lower leaflet boundary
