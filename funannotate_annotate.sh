#!/bin/bash -l

#PBS -l nodes=1:ppn=24,walltime=3:00:00,mem=60gb
#PBS -m abe
#PBS -A figueroa
#PBS -M lixx3627@umn.edu
#PBS -N fun_functional

cd $PBS_O_WORKDIR

#module load funannotate/1.5.0
export AUGUSTUS_CONFIG_PATH=/home/figueroa/shared/Analysis/ug99_Jan/ug99_annotation/ug99_decon_afterBP/3.2.3.CentOS7/config/

#funannotate annotate -i ./ug99_fun_evidence --sbt ./Ug99_template_newTBL.sbt --iprscan ./iprscan/Ug99_afterBP_05221019.xml --species "Puccinia graminis f. sp. tritici" --isolate Ug99 --cpus 24 --busco_db basidiomycota
