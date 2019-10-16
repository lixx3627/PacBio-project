# #  Map PB raw reads to ug99 arrow+2xpilon assembly  – use blasr

#!/bin/bash -l
#PBS -l nodes=1:ppn=8,walltime=36:00:00,mem=16gb
#PBS -m abe
#PBS -M lixx3627@umn.edu
 
module load blasr/5.3.5
cd $PBS_O_WORKDIR
# Run blasr to map pacbio raw reads to arrow+2Xpilon polished assembly (660 contigs, fix all)
blasr /home/figueroa/shared/Data/ug99/input.fofn /home/figueroa/shared/Analysis/ug99_Jan/pilon/analysis/170m_arrow_2Xpilon_analysis/ug99_PB_all_170m_arrow_2XPilon.fasta --out ../analysis/PBreads_vs_ug99_PB_all_170m_arrow_2XPilon.bam --bam --bestn 10 --minMatch 12 --maxMatch 30 --nproc 8 --minSubreadLength 50 --minAlnLength 50 --minPctSimilarity 70 --minPctAccuracy 70 --hitPolicy randombest --randomSeed 1
