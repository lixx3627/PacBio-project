#!/bin/bash -l

#PBS -l nodes=1:ppn=20,walltime=20:00:00
#PBS -m abe
#PBS -A figueroa
#PBS -M lixx3627@umn.edu
#PBS -N fun_predict

cd $PBS_O_WORKDIR
#Using version 1.5.0
module load funannotate/1.5.0
export EVM_HOME=/panfs/roc/msisoft/evidencemodeler/1.1.1/
#Make sure you copy the Augustus folder /panfs/roc/msisoft/augustus/3.2.3.CentOS7 to another location because Augustus will write to that location when it runs.
export AUGUSTUS_CONFIG_PATH=/home/figueroa/shared/Analysis/ug99_Jan/ug99_annotation/ug99_decon_afterBP/3.2.3.CentOS7/config/
export GENEMARK_PATH=/panfs/roc/msisoft/genemark/4.32/
export BAMTOOLS_PATH=/panfs/roc/msisoft/bamtools/2.5.1/bin/

#funannotate predict -i ./Ug99V2AP2_537ctgs_mask.fa -o ./ug99_fun_evidence --species Puccinia_graminis_tritici --isolate Ug99 --name PGTUg99_ --pasa_gff ug99_fun_evidence/training/funannotate_train.pasa.gff3:20 --other_gff ug99_fun_evidence/training/FL_codingQuarry/out/combined_CQ_PM.gff3:20 --rna_bam ug99_fun_evidence/training/hisat2.coordSorted.bam --busco_db basidiomycota --transcript_evidence ug99_fun_evidence/training/funannotate_train.trinity-GG.fasta /home/figueroa/shared/pgt_21_annotate/jgi_est_clusters/Pucciniomycotina.ESTS.fa /home/figueroa/shared/Data/Pgt_Avr_sequences/HSP590_Transcripts.fa --ploidy 2 --keep_no_stops --cpus 20

funannotate predict -i ./Ug99V2AP2_537ctgs_mask.fa -o ./ug99_fun_evidence --species Puccinia_graminis_tritici --isolate Ug99 --name PGTUg99_ --pasa_gff ug99_fun_evidence/training/funannotate_train.pasa.gff3:20 --other_gff ug99_fun_evidence/training/FL_codingQuarry/out/combined_CQ_PM.gff3:20 --rna_bam ug99_fun_evidence/training/hisat2.coordSorted.bam --busco_db basidiomycota --transcript_evidence ug99_fun_evidence/training/funannotate_train.trinity-GG.fasta /home/figueroa/shared/pgt_21_annotate/jgi_est_clusters/Pucciniomycotina.ESTS.fa /home/figueroa/shared/Data/Pgt_Avr_sequences/HSP590_Transcripts.fa --ploidy 2 --cpus 20
