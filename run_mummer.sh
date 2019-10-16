#!/bin/bash -l
#PBS -l nodes=1:ppn=12,walltime=70:00:00
#PBS -m abe
#PBS -M lixx3627@umn.edu
#PBS -N mummer
 
cd $PBS_O_WORKDIR
# compare assembly Pgt210_canu and ug99_canu
module load mummer
# compare ug99 nucleus A and nucleus C, use A as reference
nucmer -maxmatch -l 100 -c 500 ug99_karyonA.fa ug99_karyonC.fa -prefix ug99A_vs_ug99C
gzip -9 ug99A_vs_ug99C.delta
# the .delta.gz file can be input in assemblytics


### use mummer 4.0 to run dnadiff
cd $PBS_O_WORKDIR
module load mummer/4.0.0.beta2  

nucmer --maxmatch -t 12 ../updated_210V2AP2_karyonA_232tigs.fa ../Ug99V2AP2_karyonA_329tigs_update.fa -p 210A_Ug99A_new
dnadiff -d 210A_Ug99A_new.delta -p 210A_Ug99A_new

nucmer --maxmatch -t 12 ../Ug99V2AP2_karyonA_329tigs_update.fa ../Ug99V2AP2_karyonC_163tigs_update.fa -p Ug99A_Ug99C_new
dnadiff -d Ug99A_Ug99C_new.delta -p Ug99A_Ug99C_new

nucmer --maxmatch -t 12 ../updated_210V2AP2_karyonB_167tigs.fa ../Ug99V2AP2_karyonC_163tigs_update.fa -p 210B_Ug99C_new
dnadiff -d 210B_Ug99C_new.delta -p 210B_Ug99C_new

nucmer --maxmatch -t 12 ../updated_210V2AP2_karyonA_232tigs.fa ../Ug99V2AP2_karyonC_163tigs_update.fa -p 210A_Ug99C_new  
dnadiff -d 210A_Ug99C_new.delta -p 210A_Ug99C_new

nucmer --maxmatch -t 12 ../Ug99V2AP2_karyonA_329tigs_update.fa ../updated_210V2AP2_karyonB_167tigs.fa -p Ug99A_210B_new
dnadiff -d Ug99A_210B_new.delta -p Ug99A_210B_new

nucmer --maxmatch -t 12 ../updated_210V2AP2_karyonA_232tigs.fa ../updated_210V2AP2_karyonB_167tigs.fa -p 210A_210B
dnadiff -d 210A_210B.delta -p 210A_210B
