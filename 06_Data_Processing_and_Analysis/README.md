# 📊 Data Processing and Analysis

This module contains utility scripts for batch processing, cleaning, and formatting Molecular Dynamics simulation outputs.

The workflows are designed to streamline downstream analysis, visualization, and integration with Python-based scientific computing pipelines.

---

## 🎯 Purpose

Typical simulation campaigns generate large numbers of output files requiring:

- Format standardization
- Batch analysis
- Automated extraction of numerical data
- Preparation of datasets for plotting and statistical analysis

These scripts reduce manual processing and improve reproducibility.

---

## 📂 Contents

### batch_file_converter.sh

Batch conversion utility for transforming `.dat` files into `.xvg` format.

**Applications**

- Standardizing simulation outputs
- Preparing files for GROMACS-compatible visualization workflows
- Simplifying large-scale data management

---

### batch_rdf_analysis.sh

Automated Radial Distribution Function (RDF) calculations across multiple atom groups.

**Applications**

- Molecular interaction analysis
- Solvation structure characterization
- Membrane and ligand environment studies
- Comparative RDF workflows across simulation conditions

**Outputs**

- RDF profiles (`g(r)`)
- Coordination number distributions

---

### xvg_to_clean_dat.sh

Removes metadata from GROMACS `.xvg` files and exports clean numerical datasets.

**Applications**

- Python analysis workflows
- Statistical processing
- Machine learning dataset preparation
- Publication-quality plotting

---

## 🔬 Example Workflow

Simulation Output

↓

RDF Calculation

(`batch_rdf_analysis.sh`)

↓

Clean Numerical Data

(`xvg_to_clean_dat.sh`)

↓

Python / R Analysis

↓

Figures, Statistics & Reporting

---

## 🛠 Requirements

- Bash
- GROMACS
- Linux environment

---

## 💼 Industry Relevance

The workflows demonstrate practical skills frequently used in:

- Computational Biology
- Molecular Modeling
- Drug Discovery
- Scientific Data Engineering
- High-Throughput Simulation Analysis

Key competencies showcased:

- Batch automation
- Scientific data cleaning
- Reproducible analysis pipelines
- Large-scale simulation post-processing
