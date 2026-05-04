#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=32
#SBATCH --job-name=Gypsum_Preparation
#SBATCH --partition=multi

# Activación de entorno
eval "$(conda shell.bash hook)"
conda activate gypsum_dl_env

# Batch processing de archivos SMILES
for f in inputs/*.smi; do
    echo "Processing molecule: $f"
    srun python3 run_gypsum_dl.py --source "$f" \
        --output_folder OUTPUTS \
        --num_processors -1 \
        --max_variants_per_compound 1 \
        --add_pdb_output \
        --use_durrant_lab_filters
done
