# --------------------------------------------------------------------------------
# Script: generate_lipid_indices.tcl
# Description: Generates GROMACS .ndx files for specific lipid atoms, 
# separating them by membrane leaflet (Upper and Lower) based on Z coordinates.
# --------------------------------------------------------------------------------

proc generate_leaflet_ndx { } {
    # 1. Define Leaflet Selections (Check Z coordinates for your specific system)
    set sel_up   [atomselect top "same residue as resname DPP and z > 42"]
    set sel_down [atomselect top "same residue as resname DPP and z < 15"]

    # Mapping of selections to output files
    set work_list [list [list $sel_up "index_upper_leaflet.ndx"] \
                        [list $sel_down "index_lower_leaflet.ndx"]]

    # List of carbon atoms to extract for the index
    set carbon_list {C36 C37 C38 C39 C40 C41 C42 C43 C44 C45 C46 C47 C48 C49 C50}

    foreach item $work_list {
        set sel [lindex $item 0]
        set filename [lindex $item 1]
        
        set fileout [open $filename w]
        set all_indices [$sel get index]
        set all_names [$sel get name]

        puts "Generating $filename..."

        foreach atom_name $carbon_list {
            # Find indices for the specific atom name in the selection
            set match_indices [lsearch -all $all_names $atom_name]
            set final_idx_list {}

            foreach match $match_indices {
                # VMD indices are 0-based, GROMACS needs 1-based
                lappend final_idx_list [expr [lindex $all_indices $match] + 1]
            }

            # Write GROMACS group header
            puts $fileout "\[ $atom_name \]"

            # Format: 15 indices per line for better readability
            set count 0
            set line ""
            foreach idx $final_idx_list {
                append line [format "%8d" $idx]
                incr count
                if {$count == 15} {
                    puts $fileout $line
                    set line ""
                    set count 0
                }
            }
            # Write the remaining indices (the 'resto')
            if {$line != ""} { puts $fileout $line }
        }
        close $fileout
        $sel delete
    }
    puts "Indexing complete. Files generated: index_upper_leaflet.ndx, index_lower_leaflet.ndx"
}

# To run: source generate_lipid_indices.tcl; generate_leaflet_ndx
