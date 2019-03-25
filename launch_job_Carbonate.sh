#!/bin/bash

#PBS -N DpCAGE_job_PA42_v4.0
#PBS -k o
#PBS -l nodes=1:ppn=16,vmem=48gb
#PBS -l walltime=8:00:00

module load java

echo "Launching job"

cd /N/dc2/scratch/rtraborn/Daphnia_CAGE_PA42_v4_0/DpCAGE
./xdoit > err

echo "Job complete"
