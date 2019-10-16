#!/bin/bash -l

#PBS -l nodes=1:ppn=2,walltime=60:00:00
#PBS -m abe
#PBS -M lixx3627@umn.edu
#PBS -N fun_train


cd $PBS_O_WORKDIR
#Using version 1.5.0
module load funannotate/1.5.0
export TRINITYHOME=/panfs/roc/msisoft/trinityrnaseq/2.5.1/
export PASAHOME=/panfs/roc/msisoft/pasa/2.3.3/

# run train step on masked ug99 after decontamination and breakpoints:
funannotate train -i ./Ug99V2AP2_537ctgs_mask.fa -o ug99_fun_evidence -l /home/figueroa/shared/pgt_21_annotate/raw_rna_seq/R1_mod_rnaseq.fastq.gz -r /home/figueroa/shared/pgt_21_annotate/raw_rna_seq/R2_mod_rnaseq.fastq.gz -s /home/figueroa/shared/pgt_21_annotate/raw_rna_seq/SE_mod_rnaseq.fastq.gz --species Puccinia_graminis_tritici --isolate Ug99 --cpus 30
# this step cannot be finshed within the time so I have to run this again using the script below

# run train pasa step with cpu =2 :
funannotate train -i Ug99V2AP2_537ctgs_mask.fa -o ./ug99_fun_evidence -l ./ug99_fun_evidence/training/trimmomatic/trimmed_left.fastq.gz -r ./ug99_fun_evidence/training/trimmomatic/trimmed_right.fastq.gz -s ./ug99_fun_evidence/training/trimmomatic/trimmed_single.fastq.gz --left_norm ./ug99_fun_evidence/training/normalize/trimmed_left.fastq.gz.normalized_K25_C50_pctSD200.fq --right_norm ./ug99_fun_evidence/training/normalize/trimmed_right.fastq.gz.normalized_K25_C50_pctSD200.fq  --single_norm ./ug99_fun_evidence/training/normalize/trimmed_single.fastq.gz.normalized_K25_C50_pctSD200.fq --species Puccinia_graminis_tritici --isolate Ug99 --cpus 2 --no_trimmomatic --no_normalize_reads --trinity ./ug99_fun_evidence/training/trinity.fasta
