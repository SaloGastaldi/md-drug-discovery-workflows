#!/bin/bash
#SBATCH --job-name=MD_Production
#SBATCH --partition=multi
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --time=2-00:00:00

# Clean environment and load GROMACS module
module purge
module load gromacs/2023.2

# Set the number of OpenMP threads according to the CPU allocation
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

# Run a production Molecular Dynamics simulation
# -deffnm: simulation file prefix
# -cpi: resume from checkpoint if the previous job was interrupted
# srun enables resource-aware execution under SLURM
srun gmx_mpi mdrun -v -deffnm production_run -cpi production_run.cpt






