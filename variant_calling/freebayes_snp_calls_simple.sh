#!/bin/bash -l

#PBS -l nodes=1:ppn=8,walltime=8:00:00
#PBS -m abe
#PBS -M lixx3627@umn.edu
#PBS -N freebayes_calls
cd $PBS_O_WORKDIR

module load samtools
module load freebayes/20161103 parallel gcc/4.9.2

export PATH="$PATH:/home/figueroa/lixx3627/src/vcflib/bin/"
# give reference genome
GENOME=./Ug99V2AP2_537ctg.fasta

# Note you need a fai file for the fasta file in the same folder;                                                                                         
samtools faidx $GENOME
#Just need to create regions once, comment this out after performing once for a given genome                                                               
# generate region files for ug99                                                                                                                                                           
/soft/freebayes/20161103/bin/fasta_generate_regions.py ./Ug99V2AP2_537ctg.fasta 100000 > Ug99V2AP2_537ctg.fa.regions               

# run snp calls for mapping IR_01 reads to Ug99 assembly                                                                                    
./freebayes-parallel Ug99V2AP2_537ctg.fa.regions 24 -f $GENOME ./ERR2099124_rm_sorted.bam > IR01_IlluminaReads_to_Ug99_537ctg.vcf 
