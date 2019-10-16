# script to extract uniquely-mapped reads

#!/bin/bash -l
#PBS -l nodes=1:ppn=8,walltime=4:00:00
#PBS -m abe
#PBS -M lixx3627@umn.edu

cd $PBS_O_WORKDIR
module load samtools
module load bedtools/2.27.1


# sort before bamToFastq BAM file is sorted/grouped by the read name. This keeps the resulting records in the two output FASTQ files in the same order. 
#samtools sort -n ug99_mapping_to_ug99A.bam -o ug99_mapping_to_ug99A_qsort.bam
#samtools sort -n ug99_mapping_to_ug99C.bam -o ug99_mapping_to_ug99C_qsort.bam
#bedtools bamtofastq -i ug99_mapping_to_ug99A_qsort.bam -fq ug99_reads_mappingTo_ug99_karyonA_R1.fastq -fq2 ug99_reads_mappingTo_ug99_karyonA_R2.fastq 
#bedtools bamtofastq -i ug99_mapping_to_ug99C_qsort.bam -fq ug99_reads_mappingTo_ug99_karyonC_R1.fastq -fq2 ug99_reads_mappingTo_ug99_karyonC_R2.fastq


# extract 210 reads that were mapped to 210_A, 210_B separately
#bedtools intersect -abam 210_to_Ug99/210wtto210V2AP2_99_98string.bam -b 210_karyonA_sort.bed > 210_mapping_to_210A.bam
#bedtools intersect -abam 210_to_Ug99/210wtto210V2AP2_99_98string.bam -b 210_karyonB_sort.bed > 210_mapping_to_210B.bam

#samtools sort -n 210_mapping_to_210A.bam -o 210_mapping_to_210A_qsort.bam
#samtools sort -n 210_mapping_to_210B.bam -o 210_mapping_to_210B_qsort.bam

#bedtools bamtofastq -i 210_mapping_to_210A_qsort.bam -fq 210_reads_mappingTo_210_karyonA_R1.fastq -fq2 210_reads_mappingTo_210_karyonA_R2.fastq
#bedtools bamtofastq -i 210_mapping_to_210B_qsort.bam -fq 210_reads_mappingTo_210_karyonB_R1.fastq -fq2 210_reads_mappingTo_210_karyonB_R2.fastq

# check how many reads in the extracted separated reads files:
for file in $(ls separated_Illumina_reads/*.fastq)
do
    echo "$file:" $(bioawk -c fastx 'END{print NR}' $file)
