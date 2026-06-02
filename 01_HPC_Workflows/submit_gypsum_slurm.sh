#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=32
#SBATCH --job-name=Gypsum_Preparation
#SBATCH --partition=multi

# Activate the Conda environment containing Gypsum-DL
eval "$(conda shell.bash hook)"
conda activate gypsum_dl_env

# Process all SMILES files located in the inputs directory
# Each file is converted into 3D-ready molecular structures
# suitable for downstream docking or virtual screening workflows
for f in inputs/*.smi; do
    echo "Processing molecule: $f"
    srun python3 run_gypsum_dl.py --source "$f" \
        --output_folder OUTPUTS \
        --num_processors -1 \
	# Generate a single representative structure per compound
        --max_variants_per_compound 1 \
        --add_pdb_output \
	# Generate a single representative structure per compound
        --use_durrant_lab_filters
done
