#!/bin/bash

#SBATCH -n 8                        # number of cores
#SBATCH -t 0-12:00                  # wall time (D-HH:MM)
#SBATCH -o slurm.%j.out             # STDOUT (%j = JobId)
#SBATCH -e slurm.%j.err             # STDERR (%j = JobId)
#SBATCH --mail-type=FAIL             # Send a notification
#SBATCH --mail-user=ssnyde11@asu.edu #my email address

module load sratoolkit/2.8.2-1

fastqDir=/home/ssnyde11/DpCAGE_v4_0

cd $fastqDir

#mkdir fastq

cd fastq

echo "Starting download"

fastq-dump SRR3356112
fastq-dump SRR3356113
fastq-dump SRR3356114
fastq-dump SRR3356115
fastq-dump SRR3356116
fastq-dump SRR3356117
fastq-dump SRR3356118
fastq-dump SRR3356119

echo "Download complete"
