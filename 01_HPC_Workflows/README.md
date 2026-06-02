# 01_HPC_Workflows

Automation workflows for running computational drug discovery pipelines in High Performance Computing (HPC) environments.

This module contains SLURM-based execution scripts designed to support scalable Molecular Dynamics simulations and ligand preparation workflows, improving reproducibility and computational efficiency in scientific computing environments.

---

## 🎯 Objectives

* Automate execution of Molecular Dynamics simulations
* Enable scalable processing of compound libraries
* Improve workflow reproducibility in HPC environments
* Support high-throughput drug discovery pipelines

---

## 📂 Contents

### submit_gromacs_slurm.sh

SLURM submission script for running production Molecular Dynamics simulations using GROMACS.

**Key Features**

* HPC execution using SLURM
* OpenMP parallelization
* Automatic thread allocation
* Checkpoint restart support (`-cpi`)
* Suitable for long-running MD production jobs

**Applications**

* Protein simulations
* Membrane systems
* Drug–target interaction studies
* Large-scale Molecular Dynamics campaigns

---

### submit_gypsum_slurm.sh

SLURM workflow for batch ligand preparation using Gypsum-DL.

**Key Features**

* Automated processing of multiple SMILES files
* Parallel execution in HPC environments
* Generation of 3D molecular structures
* Conformer and protonation-state preparation
* Batch-ready virtual screening preprocessing

**Applications**

* Virtual screening campaigns
* Compound library preparation
* Molecular docking workflows
* Drug discovery pipelines

---

## 🚀 Skills Demonstrated

* High Performance Computing (HPC)
* SLURM workload management
* Molecular Dynamics workflow automation
* GROMACS production simulations
* Batch processing of molecular datasets
* Scientific computing on Linux environments
* Reproducible computational pipelines

---

## 💼 Industry Relevance

The workflows in this module reflect tasks commonly performed in:

* Computational chemistry groups
* Drug discovery teams
* Molecular modeling departments
* Biotech and pharmaceutical R&D environments

Typical applications include simulation execution, compound preparation, workflow automation, and scaling computational experiments across HPC infrastructure.

---

## 🛠️ Technologies

* Bash
* SLURM
* GROMACS
* Gypsum-DL
* Linux
* OpenMP
* Conda Environments

---

## 🔬 Example Workflow

Compound Library (SMILES)
↓
Gypsum-DL Preparation
↓
Docking / Screening
↓
Molecular Dynamics Simulation
↓
Trajectory Analysis
↓
Drug Discovery Insights

