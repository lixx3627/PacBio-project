# calculate genome coverage of mapping Illumina reads back the the assembly

#!/bin/bash -l
#PBS -l nodes=1:ppn=4,walltime=2:00:00
#PBS -m abe
#PBS -M lixx3627@umn.edu

cd $PBS_O_WORKDIR
module load bedtools/2.27.1
# write a pipeline to process bam file to calculate genomeCov
MAPPED_reads=../../../analysis/mapped_reads/extracted_ug99_reads_Map2_Ug99_and_210

for file in $(ls $MAPPED_reads/*.bam)
do
    results_files="$(basename $file .bam).cov"
    genomeCoverageBed -ibam $file > ./new_genomeCov/$results_files
done
