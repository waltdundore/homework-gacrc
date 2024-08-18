#!/bin/bash
#SBATCH --job-name="test"
#SBATCH -D .
#SBATCH --output=./logs_%j.out
#SBATCH --error=./logs_%j.err
#SBATCH --nodelist=nodes[19,23]
#SBATCH --time=:00:20:00
#SBATCH --partition=gacrc-partition
#SBATCH --wait-all-nodes=1
# Launch on node 1
srun -lN1 -n1 -r 1 ./com_19.bash &
# launch on node 2
srun -lN1 -r 0 ./com_23.bash &
sleep 1
squeue 
squeue -s 
wait
