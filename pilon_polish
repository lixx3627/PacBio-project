# Pilon-polish

# 1. bwa mem to align Ug99 Illumina reads to ug99 arrow-polished assembly
run_bwa.pbs
#!/bin/bash -l
#PBS -l nodes=1:ppn=12,walltime=24:00:00
#PBS -m abe
#PBS -M lixx3627@umn.edu

cd $PBS_O_WORKDIR
module load bwa
module load samtools
#run bwa mem on arrow-polished ug99_170m assembly (w/o blast fiter)
bwa index ug99_PB_ALL_170m_arrow.fasta
bwa mem ug99_PB_ALL_170m_arrow.fasta /home/figueroa/shared/Data/ug99/illumina_ug99/Pgt_99_TTKSK_S1_R1_001.fastq.gz \
/home/figueroa/shared/Data/ug99/illumina_ug99/Pgt_99_TTKSK_S1_R2_001.fastq.gz | samtools view -bh -o ug99_S1_vs_ALL_170m_arrow.bam
samtools sort -@ 12 ug99_S1_vs_ALL_170m_arrow.bam -o ug99_S1_vs_ALL_170m_arrow_sorted.bam
samtools index ug99_S1_vs_ALL_170m_arrow_sorted.bam


# 2. run_pilon.pbs; run two rounds of pilon
#!/bin/bash -l
#PBS -l nodes=1:ppn=8,walltime=6:00:00,mem=252gb
#PBS -m abe
#PBS -M lixx3627@umn.edu
#PBS -q ram256g
cd $PBS_O_WORKDIR
module load pilon/1.22 

# run pilon on the intial canu assembly WITHOUT 7 contigs/contaminations removed
java -Xmx128G -jar /panfs/roc/msisoft/pilon/1.22/bin/pilon-1.22.jar --genome ug99_PB_ALL_170m_arrow.fasta --frags ug99_S1_vs_ALL_170m_arrow_sorted.bam --output ug99_PB_all_170m_arrow_1XPilon --outdir ../analysis/170m_arrow_1Xpilon_analysis/ --threads 7 --verbose --changes --tracks --vcf --fix all

# 2nd round of pilon
java -Xmx128G -jar /panfs/roc/msisoft/pilon/1.22/bin/pilon-1.22.jar --genome ug99_PB_all_170m_arrow_1XPilon.fasta --frags ug99_S1_vs_canu_170m_arrow_1XPilon_sorted.bam --output ug99_PB_all_170m_arrow\
_2XPilon --outdir ../analysis/170m_arrow_2Xpilon_analysis/ --threads 7 --verbose --changes --tracks --vcf --fix all

