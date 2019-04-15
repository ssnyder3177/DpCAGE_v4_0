#!/bin/bash

#SBATCH -n 8                        # number of cores
#SBATCH -t 0-12:00                  # wall time (D-HH:MM)
##SBATCH -A ssnyde11                # Account hours will be pulled from (commented out with double # in front)
#SBATCH -o slurm.%j.out             # STDOUT (%j = JobId)
#SBATCH -e slurm.%j.err             # STDERR (%j = JobId)
#SBATCH --mail-type=ALL             # Send a notification

module load java/latest
module load gcc/7x
module load r/3.5.2

echo "Launching job"

cd /home/ssnyde11/DpCAGE_v4_0 #update to reflect our directory structure
./xdoit > err

echo "Job complete"
