#!/bin/bash -l
#PBS -l nodes=1:ppn=2,walltime=20:00:00
#PBS -m abe
#PBS -A figueroa
#PBS -M lixx3627@umn.edu
#PBS -N fun_fix
cd $PBS_O_WORKDIR

#Using version 1.5.0
module load funannotate/1.5.0

funannotate fix -i ug99_fun_evidence/predict_results/Puccinia_graminis_tritici_Ug99.gbk -t ug99_fun_evidence/predict_results/Puccinia_graminis_tritici_Ug99.tbl
