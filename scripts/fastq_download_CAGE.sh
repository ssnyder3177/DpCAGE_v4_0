#!/bin/bash
#PBS -k o
#PBS -l nodes=1:ppn=8,vmem=16gb,walltime=1:00:00
#PBS -N fastq_download_DpCAGE
#PBS -q debug

module load sra-toolkit

fastqDir=/N/dc2/scratch/rtraborn/Daphnia_CAGE_PA42_v4_0

echo "Starting download"

cd $fastqDir

fastq-dump SRR3356112
fastq-dump SRR3356113
fastq-dump SRR3356114
fastq-dump SRR3356115
fastq-dump SRR3356116
fastq-dump SRR3356117
fastq-dump SRR3356118
fastq-dump SRR3356119

echo "Download complete"
