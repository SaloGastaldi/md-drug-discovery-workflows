# --------------------------------------------------------------------------------
# Script: protein_clustering.tcl
# Description: Automated RMSD clustering of protein backbone conformations.
# Generates time distribution data and average structures for each cluster.
# Application:
# Identifies dominant conformational states sampled during the trajectory
# and generates representative average structures for downstream analyses
# such as docking, visualization, or ensemble-based workflows.
# --------------------------------------------------------------------------------

# 1. Cluster calculation (Backbone, 1.2A cutoff)
# RMSD-based clustering of backbone conformations.
# Frames with similar structures are grouped together into conformational states.
set cls [measure cluster [atomselect 0 "backbone"] cutoff 1.2 num 5 distfunc rmsd]
set n_cls [llength $cls]
puts "Found $n_cls clusters."

# 2. Iterate over each cluster to extract structures
set i 0
foreach n $cls {
    incr i
    puts "Processing Cluster $i..."

    set file [open "cluster_${i}_time_distrib.dat" w]
    
    # Create temporary files for concatenation
    set out_pdb "cluster_${i}_ensemble.pdb"
    
    foreach frame_idx $n {
        # Store cluster membership over simulation time.
        # Useful for identifying state transitions and population distributions.
        puts $file "$frame_idx 1"
        
        # Extract and write PDB for this frame
        set sel [atomselect 0 "backbone" frame $frame_idx]
        $sel writepdb "temp_frame.pdb"
        
        # Concatenate all cluster members into a single ensemble structure
        if {![file exists $out_pdb]} {
            file copy -force "temp_frame.pdb" $out_pdb
        } else {
            set out [open $out_pdb a]
            set in [open "temp_frame.pdb" r]
            puts $out [read $in]
            close $in
            close $out
        }
    }
    close $file

    # 3. Calculate and save the AVERAGE POSITION structure
    mol new $out_pdb waitfor all
    set all_atoms [atomselect top "all"]
    # Calculate the average atomic coordinates for the cluster,
    # generating a representative structure of the conformational state. 
    set avg_pos [measure avpos $all_atoms]
    
    $all_atoms set {x y z} $avg_pos
    $all_atoms writepdb "avg_structure_cluster_${i}.pdb"
    
    # Remove temporary files before processing the next cluster.
    mol delete top
    file delete "temp_frame.pdb"
    puts "Finished Cluster $i. Average structure saved."
}

mol top 0
