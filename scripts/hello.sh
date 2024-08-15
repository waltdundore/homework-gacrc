#!/bin/bash
#
### select the partition "gacrc-partition"
#SBATCH --partition=gacrc-partition
### set email address for sending job status
#SBATCH --mail-user=user@host
### account - essentially your research group
#SBATCH --account=gacrc
### select number of nodes
#SBATCH --nodes=2
### select number of tasks per node
#SBATCH --ntasks-per-node=4
### request 15 min of wall clock time
#SBATCH --time=00:15:00
### memory size required per node
#SBATCH --mem=256MB

### You may need this if there are settings in your .bashrc
### e.g. setup for Anaconda
. ~/.bashrc

### Whatever modules you used (e.g. picotte-openmpi/gcc)
### must be loaded to run your code.
### Add them below this line.
# module load FIXME

echo "hello, world"
