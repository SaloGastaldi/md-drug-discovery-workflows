# Biophysics & Molecular Dynamics Automation Suite
**Developed by Dra. Salomé Gastaldi**

This repository contains a comprehensive collection of automation and analysis tools designed for high-throughput Molecular Dynamics (MD) simulations and Computational Biophysics. These tools are optimized for studying **membrane-protein systems**, **drug-lipid interactions**, and **lipid bilayer dynamics**.

## 🚀 Key Capabilities
* **HPC Management:** Automated SLURM submission scripts with environment configuration and checkpoint support.
* **Membrane Biophysics:** Advanced calculation of order parameters ($S_{CD}$), area per lipid, bilayer thickness, and trans/gauche isomerization.
* **Molecular Orientation:** Time-resolved order tensor analysis and orientation mapping (Tilt/Phi) for ligands and spin labels within lipid matrices.
* **Virtual Screening:** Automated ensemble docking workflows using AutoDock Vina and Gypsum-DL.

---

## 📂 Module Descriptions

### 01. HPC & System Management
* `submit_gromacs_slurm.sh`: High-efficiency GROMACS execution with OpenMP/MPI balancing and checkpointing.
* `submit_gypsum_slurm.sh`: Batch processing of SMILES for 3D ligand library generation.

### 02. System Preparation & Virtual Screening
* `prepare_docking_system.sh`: Automated receptor and ligand preparation using MGLTools.
* `run_vina_ensemble.sh`: Pipeline for docking across multiple protein pockets (Ensemble Docking).

### 03. Membrane & Lipid Analysis
* `membrane_thickness_analyzer.tcl`: Frame-by-frame bilayer width quantification using reference atoms.
* `lipid_conformation_analysis.tcl`: Statistical analysis of acyl chain isomerization (Trans/Gauche states).
* `lipid_order_master.sh`: Large-scale $S_{CD}$ parameter calculation for multiple topologies.
* `pore_analysis_hole.sh`: Automated workflow for pore radius calculation using HOLE.
* `generate_lipid_indices.tcl`: Leaflet-specific index generation based on Z-coordinates.

### 04. Ligand Dynamics & Protein Analysis
* `residue_orientation_analyzer.tcl`: Quantifies Tilt ($\theta$) and Azimuth ($\phi$) angles for specific molecular vectors.
* `time_resolved_order_tensor.tcl`: Sliding window approach for angular dispersion and order tensors.
* `hbond_master_analysis.sh`: Systematic H-bond mapping for drug-lipid-water interfaces.
* `protein_clustering.tcl`: RMSD-based clustering to identify representative protein conformations.

### 05. Visualization & Interactive Tools
* `visualize_molecular_vectors.tcl`: Real-time 3D vector rendering in VMD for methodology validation.
* `draw_membrane_planes.tcl`: Visual representation of membrane boundaries at specific Z-coordinates.
* `interactive_geometry.tcl`: VMD tool for manual calculation of improper dihedrals on screen.

### 06. Data Processing & Statistical Analysis
* `xvg_to_clean_dat.sh`: Data extraction and header cleaning for Python/Pandas compatibility.
* `batch_rdf_analysis.sh`: Automated Radial Distribution Function (RDF) calculation for multiple groups.

---

## 🛠 Tech Stack
* **Languages:** Bash, TCL (VMD scripting), Python.
* **Software:** GROMACS, VMD, AutoDock Vina, HOLE, Open Babel, Gypsum-DL.
* **Environment:** Linux HPC Clusters (SLURM).

---

## 📈 Scientific Impact
These tools facilitate the biophysical characterization of complex systems, reducing post-processing time and ensuring reproducible data analysis in drug discovery and membrane research pipelines.

---
**Contact:** [msalomegastaldi@gmail.com] 
