#!/bin/bash -l

#PBS -l nodes=1:ppn=2,walltime=80:00:00
#PBS -m abe
#PBS -A figueroa
#PBS -M lixx3627@umn.edu
#PBS -N fun_update

cd $PBS_O_WORKDIR

#module load funannotate/1.5.0

# try the new version funannotate 1.6.0 - Aug 9 2019
module load funannotate/1.6.0
export TRINITYHOME=/panfs/roc/msisoft/trinityrnaseq/2.5.1/
export PASAHOME=/panfs/roc/msisoft/pasa/2.3.3/
#export PATH="/home/figueroa/shared/Analysis/ug99_Jan/ug99_annotation/pgt210_annotation/fasta36/36.3.6d_serial/bin/fasta:$PATH"
export PATH="~/src/fasta:$PATH"
#funannotate update -i ./ug99_fun_evidence --cpus 20 --pasa_config /scratch.global/lixx3627/funannotate/sqlite_tmp/ug99_afterBP_sqlite/alignAssembly.txt

# modify the path of PASA sql dataset to the tmp folder in /scratch foler
funannotate update -i ./ug99_fun_evidence --cpus 20 --pasa_config /scratch.global/lixx3627/funannotate/Ug99_1.6_annotate/alignAssembly.txt 
