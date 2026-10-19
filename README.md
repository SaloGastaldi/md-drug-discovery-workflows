
# 🧬 Molecular Modeling, Molecular Dynamics & Membrane Biophysics Workflows

A collection of reusable scripts and computational workflows for molecular modeling, molecular dynamics simulations, membrane biophysics, and structure-based drug discovery.

Developed through academic research, these tools support HPC-based simulation execution, molecular docking, structural and trajectory analysis, characterization of biomolecular interactions, and scientific data processing.

The repository brings together workflows using GROMACS, AutoDock Vina, VMD/TCL, Bash, and SLURM, with an emphasis on reproducibility, automation, and quantitative analysis of molecular systems.

---

## 🎯 Repository Scope

The repository is organized into six modules covering complementary aspects of molecular modeling and computational biophysics.

### 🖥️ HPC Workflow Automation

SLURM-based workflows for running molecular dynamics simulations and preparing compound libraries in High Performance Computing environments.

**Main capabilities:**

- GROMACS production simulation execution
- OpenMP parallelization
- Checkpoint-based simulation restart
- Batch ligand preparation using Gypsum-DL
- Processing of multiple SMILES inputs
- HPC workflow automation

### ⚛️ Docking & System Preparation

Workflows for receptor and ligand preparation, molecular docking, and virtual screening using AutoDock Vina.

**Main capabilities:**

- Ligand and receptor preparation
- PDB to PDBQT conversion
- Preparation of docking-ready molecular systems
- Ensemble docking across multiple receptor conformations
- Docking across predefined binding pockets
- Automated execution and logging of docking calculations

### 🧫 Membrane Biophysics Analysis

Quantitative characterization of lipid membrane structure, organization, and molecular interactions from molecular dynamics trajectories.

**Main analyses:**

- Membrane thickness
- Lipid and solvent density profiles
- Lipid deuterium order parameters (SCD)
- Trans/gauche conformational analysis
- Molecular insertion depth and Z-position tracking
- Molecular orientation and PNP tilt
- Leaflet-specific analysis
- Pore radius characterization using HOLE

These workflows support the investigation of membrane organization, lipid packing, molecular insertion, and membrane perturbation mechanisms.

### 🔬 Ligand and Protein Dynamics

Trajectory-based characterization of molecular interactions, structural states, and orientational dynamics.

**Main analyses:**

- Hydrogen-bond analysis
- Ligand–membrane and ligand–water interactions
- Protein conformational clustering
- Molecular tilt and azimuthal angles
- Orientational order tensors and principal axes
- Time-resolved molecular ordering
- Spin-labeled lipid orientation analysis
- Representative conformational state identification

These tools support mechanistic interpretation of molecular interactions and structural organization in biomolecular systems.

### 📊 Scientific Data Processing & Analysis

Utilities for processing, converting, and preparing molecular simulation outputs for downstream analysis.

**Main capabilities:**

- Batch file conversion
- Radial Distribution Function (RDF) calculations
- Coordination number analysis
- GROMACS XVG data cleaning
- Numerical data extraction
- Preparation of simulation data for Python or R analysis
- Reproducible post-processing workflows

### 🎨 Scientific Visualization

VMD/TCL-based tools for molecular visualization, structural inspection, and geometric analysis.

**Main capabilities:**

- Membrane boundary visualization
- Molecular vector representation
- Tilt and orientation inspection
- Interactive geometric measurements
- Improper dihedral calculations
- Ligand filtering and system modification
- Structural validation and visualization

---

## 📂 Repository Structure

```text
md-drug-discovery-workflows/
│
├── 01_HPC_Workflows/
│
├── 02_Docking_and_System_Preparation/
│
├── 03_Membrane_Biophysics_Analysis/
│
├── 04_Ligand_and_Protein_Dynamics/
│
├── 05_Visualization/
│
└── 06_Data_Processing_and_Analysis/
```

Each module contains a dedicated README describing its scripts, objectives, applications, and technologies.

The modules can be used independently or combined according to the molecular system and research objectives.

---

## 🔬 Example Computational Workflows

The following diagrams illustrate possible combinations of the available tools rather than a single fully integrated pipeline.

### Molecular Docking & Simulation

```text
Receptor & Ligand Preparation
             ↓
       Ensemble Docking
             ↓
   Molecular Dynamics Simulation
             ↓
Protein/Ligand Interaction Analysis
             ↓
    Structural Interpretation
```

### Membrane Biophysics

```text
Molecular Dynamics Trajectories
             ↓
   Membrane Structural Analysis
             ↓
Lipid Ordering & Conformational Analysis
             ↓
Molecular Orientation & Interaction Analysis
             ↓
    Biophysical Interpretation
```

### HPC Automation & Scientific Data Processing

```text
Simulation / Ligand Preparation Jobs
             ↓
      SLURM-Based Execution
             ↓
     Simulation Output Processing
             ↓
    Batch Analysis & Data Cleaning
             ↓
Visualization & Statistical Analysis
```

---

## 🛠️ Technologies

### Programming & Scripting

- Bash
- TCL
- Python
- AWK

### Molecular Modeling & Simulation

- GROMACS
- AutoDock Vina
- MGLTools / AutoDockTools
- Gypsum-DL
- Open Babel
- HOLE
- VMD

### Scientific Computing

- Linux
- SLURM
- HPC Clusters
- OpenMP
- Conda Environments

---

## 🧪 Scientific Applications

The workflows support computational investigations involving:

- Protein–ligand interactions
- Molecular docking and virtual screening
- Protein conformational dynamics
- Ligand orientation and molecular interactions
- Lipid membrane structure and organization
- Membrane-active compounds
- Drug–membrane interactions
- Molecular insertion and partitioning
- Lipid ordering and conformational dynamics
- Membrane-associated molecular probes
- Molecular interaction and structural analysis

The repository reflects the application of computational molecular modeling and quantitative biophysical analysis to investigate molecular mechanisms in biological systems.

---

## 💼 Industry Relevance

These workflows demonstrate computational approaches relevant to:

- Molecular Modeling
- Computational Biophysics
- Drug Discovery
- Computational Chemistry
- Membrane Biophysics
- Structure-Based Drug Design
- Pharmaceutical and Biotechnology R&D
- Scientific Computing
- HPC-Based Molecular Simulations

The repository emphasizes practical skills in scientific workflow automation, molecular simulation analysis, reproducible computational research, and interpretation of molecular-level data.

The modular organization supports adaptation of individual tools to different research questions and molecular systems, subject to their specific input requirements and assumptions.

---

## 👩‍🔬 Author

**Salomé Gastaldi, PhD**

Computational Biophysics | Molecular Modeling | Molecular Dynamics

- **LinkedIn:** [María Salomé Gastaldi](https://www.linkedin.com/in/mar%C3%ADa-salom%C3%A9-gastaldi/)
- **GitHub:** [SaloGastaldi](https://github.com/SaloGastaldi)

