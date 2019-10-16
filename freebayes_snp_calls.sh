#!/bin/bash -l

#PBS -l nodes=1:ppn=4,walltime=96:00:00
#PBS -m abe
#PBS -M lixx3627@umn.edu


cd $PBS_O_WORKDIR

#Load required modules
module load freebayes/20161103 parallel liblzma/5.2.2 gcc/4.9.2

#Install your own vcflib for filtering because the version on MSI is old and broken
VCFLIB="/home/figueroa/lixx3627/src/vcflib/bin"
export PATH="$PATH:/home/figueroa/lixx3627/src/vcflib/bin/"
#GENOME="/home/kianians/millerme/nifa-crown-rust/reference_genomes/"

#Call SNPs with FreeBayes

# Note you need a fai file for the fasta file in the same folder; 
#Just need to create regions once, comment this out after performing once for a given genome
#/soft/freebayes/20161103/bin/fasta_generate_regions.py ug99_PB_all_170m_arrow_2XPilon.fasta 100000 > ./ug99_PB_all_170m_arrow_2XPilon.fa.regions

#Call SNPs for mapping ug99_S1 illumia reads to ug99 arrow+2xpilon, and then get stats.
./freebayes-parallel ug99_PB_all_170m_arrow_2XPilon.fa.regions 24 -f ug99_PB_all_170m_arrow_2XPilon.fasta /home/figueroa/shared/Analysis/ug99_Jan/bwa_cmp_210_and_ug99/ug99_S1_vs_ug99_arrow_2XPilon_sorted.bam > ug99_S1_vs_ug99_arrow_2XPilon.vcf
