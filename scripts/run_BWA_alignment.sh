#!/bin/bash

#Setting variables:
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${DIR}/configfile

BWAdir=${BASEDIR}/${EXPERIMENT}/BWAdir

mkdir ${BWAdir}
mkdir ${BWAdir}/${GENOME_DIR}
ln -s ${BASEDIR}/${GENOME_DIR}/${GENOME_FILE} ${BWAdir}/${GENOME_DIR}/${GENOME_FILE}


cd ${BWAdir}

echo "Indexing the Paramecium genome using bwa ..."
echo "bwa index ${GENOME_DIR}/${GENOME_FILE}"
#${BWA}    index ${GENOME_DIR}/${GENOME_FILE}

echo "Starting alignments ..."
for fq in ${fastqDIR}/*_trno_tagdusted.fq;
do

 	echo "bwa aln -t ${THREADS} -n 3 ${GENOME_DIR}/${GENOME_FILE} -f $(basename ${fq} .fq).sai ${fq}"
#  	${BWA} aln -t ${THREADS} -n 3 ${GENOME_DIR}/${GENOME_FILE} -f $(basename ${fq} .fq_trno_tagdusted.fq).sai ${fq}

echo "bwa samse ${GENOME_DIR}/${GENOME_FILE} $(basename $fq .fq).sai \
	${fastqDIR}/${fq} | \
	${SAMTOOLS} view -uS - | \
	${SAMTOOLS} sort -O BAM - > $(basename $fq _trno_tagdusted.fq)_sorted.bam"

echo "$fq"

echo "${BWA} samse ${GENOME_DIR}/${GENOME_FILE} $(basename $fq .fq_trno_tagdusted.fq).sai $fq | ${SAMTOOLS} view -uS - | ${SAMTOOLS} sort -O BAM - > $(basename $fq .fq_trno_tagdusted.fq)_sorted.bam"
#${BWA} samse ${GENOME_DIR}/${GENOME_FILE} $(basename $fq .fq_trno_tagdusted.fq).sai $fq | ${SAMTOOLS} view -uS - | ${SAMTOOLS} sort -O BAM - > $(basename $fq .fq_trno_tagdusted.fq)_sorted.bam

echo "samtools index -b $(basename $fq .fq_trno_tagdusted.fq)_sorted.bam "
#${SAMTOOLS} index -b $(basename $fq .fq_trno_tagdusted.fq)_sorted.bam

#FILTERED_BAM=$(basename $fq _trno_tagdusted.fq)_filtered.bam
#.. post-alignment filtering for proper alignments and MAPQ >= 10:
#
echo "${SAMTOOLS} view -f 2 -q 10 -u ${SORTED_BAM} | ${SAMTOOLS} sort -O BAM -@ 10 - > $(basename $fq _trno_tagdusted.fq)_filtered.bam"
${SAMTOOLS} view -h -F 4 -q 10 -u $(basename $fq .fq_trno_tagdusted.fq)_sorted.bam | ${SAMTOOLS} sort -O BAM -@ 8 - > $(basename $fq .fq_trno_tagdusted.fq)_filtered.bam

echo "samtools index -b $(basename $fq .fq_trno_tagdusted.fq)_filtered.bam"
${SAMTOOLS} index -b $(basename $fq .fq_trno_tagdusted.fq)_filtered.bam

done
