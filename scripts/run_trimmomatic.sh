#!/bin/bash

#Setting variables:
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/configfile


Reads=${SAMPLE}
suffix=fq

for rep in rep1 rep2 rep3; do
	ReadsIN="${Reads}_${rep}_1.${suffix} ${Reads}_${rep}_2.${suffix}" 
	ReadsOUT="${Reads}_${rep}_trimmed_R1.${suffix} ${Reads}_${rep}_unpaired_R1.${suffix} ${Reads}_${rep}_trimmed_R2.${suffix} ${Reads}_${rep}_unpaired_R2.${suffix}"

	echo "Clipping TrueSeq2 adapaters from the reads using Trimmomatic ..."

	java -classpath ${TRIMMOMATIC} \
	        org.usadellab.trimmomatic.TrimmomaticPE \
	        -threads ${THREADS} \
	        ${ReadsIN} \
	        ${ReadsOUT} \
	        ILLUMINACLIP:${TruSeq2PE}:2:30:10 TRAILING:20 MINLEN:25
done
