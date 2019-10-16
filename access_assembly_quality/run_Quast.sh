# quast for canu assembly (arrow_1Xpilon fix indels and arrow_2Xpilon fix indels)

qsub run_quast.pbs
###########run_quast.pbs###############
#!/bin/bash -l
#PBS -l nodes=1:ppn=8,walltime=2:00:00
#PBS -M lixx3627@umn.edu
#PBS -m abe
 
cd $PBS_O_WORKDIR
 
module load quast/4.6.3
# quast for ug99_Canu (660 contigs) arrow+1xpilon fix all and arrow+2xpilon fix all
quast.py -t 8 /home/figueroa/shared/Analysis/ug99_Jan/pilon/analysis/170m_arrow_1Xpilon_analysis/ug99_PB_all_170m_arrow_1XPilon.fasta -o ug99_arrow_1xpilon_all -l ug99_arrow_1xpilon_all
quast.py -t 8 /home/figueroa/shared/Analysis/ug99_Jan/pilon/analysis/170m_arrow_2Xpilon_analysis/ug99_PB_all_170m_arrow_2XPilon.fasta -o ug99_arrow_2xpilon_all -l ug99_arrow_2xpilon_all
 
