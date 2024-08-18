#!/bin/bash
#SBATCH --job-name=hostname_check
#SBATCH --nodes=ALL
#SBATCH --ntasks-per-node=1
#SBATCH --time=00:05:00

srun hostname

