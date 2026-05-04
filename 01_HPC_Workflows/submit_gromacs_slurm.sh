#!/bin/bash
#SBATCH --job-name=MD_Production
#SBATCH --partition=multi
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --time=2-00:00:00

# Carga de módulos y configuración de entorno
module purge
module load gromacs/2023.2

# Configuración de hilos OpenMP basada en la reserva de SLURM
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

# Ejecución paralela con srun
# -cpi: Permite continuar desde un checkpoint si el trabajo se interrumpe
srun gmx_mpi mdrun -v -deffnm production_run -cpi production_run.cpt






