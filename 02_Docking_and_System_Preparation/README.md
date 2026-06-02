# 02_Docking_and_System_Preparation

Automation workflows for molecular docking campaigns, including receptor and ligand preparation as well as ensemble docking across multiple protein conformations.

This module contains scripts designed to streamline virtual screening workflows by preparing molecular systems for docking and automating AutoDock Vina execution across multiple binding pockets or receptor states.

---

## 🎯 Objectives

* Automate ligand and receptor preparation
* Standardize docking-ready system generation
* Enable ensemble docking workflows
* Support structure-based drug discovery campaigns
* Improve reproducibility of virtual screening analyses

---

## 📂 Contents

### prepare_docking_system.sh

Workflow for preparing ligands and receptors for AutoDock Vina using MGLTools (AutoDockTools).

**Key Features**

* Ligand conversion from PDB to PDBQT
* Receptor preparation with hydrogen addition
* Generation of docking-ready molecular systems
* Standardized input preparation for virtual screening

**Applications**

* Structure-based drug discovery
* Molecular docking studies
* Hit identification workflows
* Binding mode prediction

---

### run_vina_ensemble.sh

Automated ensemble docking workflow using AutoDock Vina.

The script executes docking calculations across multiple predefined receptor conformations or binding pockets, allowing incorporation of protein flexibility into the screening process.

**Key Features**

* Automated docking across multiple receptor states
* Batch execution of docking jobs
* Independent docking configurations per binding pocket
* Automatic logging of docking results

**Applications**

* Ensemble docking campaigns
* Flexible receptor screening
* Hit prioritization
* Binding site exploration

---

## 🚀 Skills Demonstrated

* Molecular Docking
* Ensemble Docking
* Structure-Based Drug Discovery
* AutoDock Vina
* MGLTools / AutoDockTools
* Ligand Preparation
* Receptor Preparation
* Bash Scripting
* Workflow Automation
* Virtual Screening Pipelines

---

## 🔬 Example Workflow

Ligand Structures (PDB)
↓
Ligand Preparation (PDBQT)
↓
Receptor Preparation (PDBQT)
↓
Ensemble Docking
↓
Binding Affinity Evaluation
↓
Hit Identification

---

## 💼 Industry Relevance

The workflows in this module reflect tasks commonly performed in:

* Computational chemistry teams
* Drug discovery groups
* Virtual screening campaigns
* Molecular modeling departments
* Pharmaceutical and biotech R&D environments

Typical applications include hit identification, binding mode exploration, receptor flexibility assessment, and lead prioritization.

---

## 🛠️ Technologies

* Bash
* AutoDock Vina
* MGLTools (AutoDockTools)
* Python
* Linux

---

## 📈 Drug Discovery Applications

* Virtual screening
* Hit identification
* Lead discovery
* Binding site characterization
* Ensemble docking strategies
* Receptor flexibility analysis
* Structure-based design


