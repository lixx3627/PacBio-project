# this file is in funannotate_folder_path/iprscan/funannotate_iprscan.pbs
#!/bin/bash -l

#PBS -l nodes=1:ppn=12,walltime=15:00:00,mem=200gb
#PBS -m abe
#PBS -A figueroa
#PBS -M lixx3627@umn.edu
#PBS -N fun_iprscan
#PBS -q ram256g
cd $PBS_O_WORKDIR

#module load funannotate/1.5.0
#funannotate iprscan -i ../210_predict/whole_assembly_only/update_results/Puccinia_graminis_tritici_21-0.proteins.fa -m local -o Pgt210.xml --iprscan_path /panfs/roc/msisoft/interproscan/5.23-62.0/interproscan.sh -c 12

#funannotate iprscan -i ../ug99_fun_evidence/predict_results/Puccinia_graminis_tritici_Ug99.proteins.fa -m local -o Ug99_afterBP_01132019.xml --iprscan_path /panfs/roc/msisoft/interproscan/5.23-62.0/interproscan.sh -c 12

#funannotate iprscan -i ../ug99_fun_evidence/update_results/Puccinia_graminis_tritici_Ug99.proteins.fa -m local -o Ug99_afterBP_onUpdatePr_0119.xml --iprscan_path /panfs/roc/msisoft/interproscan/5.23-62.0/interproscan.sh -c 12

