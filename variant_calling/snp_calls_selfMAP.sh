# script to call SNPs using uniquely-mapped Illumina reads mapping to the genome assembly
# use freebayes for SNP calling

#!/bin/bash -l
#PBS -l nodes=1:ppn=24,walltime=1:00:00
#PBS -m abe
#PBS -M lixx3627@umn.edu
#PBS -N snp_freebayes
cd $PBS_O_WORKDIR

module load samtools
module load freebayes/20161103 parallel gcc/4.9.2

#Install your own vcflib for filtering because the version on MSI is old and broken                                                                     
export PATH="$PATH:/home/figueroa/lixx3627/src/vcflib/bin/"

# Note you need a fai file for the fasta file in the same folder;
#Just need to create regions once, comment this out after performing once for a given genome
# generate region files for 210

# run snp calls for mapping to ug99 assembly; # run freebayes
# 210 as Ref
for input_bam in $(ls -1 ../../data/ForFeng_16012019/*mappingTo210_446ctgRef.bam)
do
    results_file="$(basename $input_bam .bam).filtered.vcf"
    ./freebayes-parallel 210V2AP2_446ctgs.fa.regions 24 -f ../../data/reference_genome/after_BP/210V2AP2_446ctgs.fa $input_bam | vcffilter -f "QUAL > 20 & QUAL / AO > 10 & SAF > 0 & SAR > 0 & RPR > 1 & RPL > 1" > $results_file
done

# 98 as Ref
for input_bam in $(ls -1 ../../data/ForFeng_16012019/*mappingTo98_333ctgRef.bam)
do
    results_file="$(basename $input_bam .bam).filtered.vcf"
    ./freebayes-parallel 98V2AP2_333ctgs.fa.regions 24 -f ../../data/reference_genome/after_BP/98V2AP2_333ctgs.fa $input_bam | vcffilter -f "QUAL > 20 & QUAL / AO > 10 & SAF > 0 & SAR > 0 & RPR > 1 & RPL > 1" > $results_file
done

# Ug99 as Ref
for input_bam in $(ls -1 ../../data/ForFeng_16012019/*mappingToUg99_537ctgRef.bam)
do
    results_file="$(basename $input_bam .bam).filtered.vcf"
    ./freebayes-parallel Ug99V2AP2_537ctg.fa.regions 24 -f ../../data/reference_genome/after_BP/Ug99V2AP2_537ctg.fa $input_bam | vcffilter -f "QUAL > 20 & QUAL / AO > 10 & SAF > 0 & SAR > 0 & RPR > 1 & RPL > 1" > $results_file
done


# identify homozygous and heterozygous SNPs
# filter homo snps and het snps
for input in $(ls -1 ./*.filtered.vcf)
do
    results_file="$(basename $input).SNPs.stats.txt"
    cat $input | vcffilter -f "AC > 0"|  vcfstats -l >$results_file
done

for input in $(ls -1 ./*.filtered.vcf)
do
    results_file="$(basename $input).hetSNPs.stats.txt"
    cat $input | vcffilter -f "AC > 0 & AC = 1"|  vcfstats -l > $results_file
done

for input in $(ls -1 ./*.filtered.vcf)
do
    results_file="$(basename $input).homoSNPs.stats.txt"
    cat $input | vcffilter -f "AC > 0 & AC = 2"|  vcfstats -l >$results_file
    
    
 # only filter snps in the variant calling file:
 #../freebayes-parallel Ug99V2AP2_537ctg.fa.regions 24 -f ../../../data/reference_genome/after_BP/Ug99V2AP2_537ctg.fa ../../../data/FilesforFeng_03012019/bam/210karyonA_ExtractedReads_mappingToUg99_537ctgRef.bam | vcffilter -f "QUAL > 20 & QUAL / AO > 10 & SAF > 0 & SAR > 0 & RPR > 1 & RPL > 1" > 210karyonA_ExtractedReads_mappingToUg99_537ctgRef.filtered.vcf
../freebayes-parallel Ug99V2AP2_537ctg.fa.regions 24 -f ../../../data/reference_genome/after_BP/Ug99V2AP2_537ctg.fa ../../../data/FilesforFeng_03012019/bam/210karyonA_ExtractedReads_mappingToUg99_537ctgRef.bam | vcffilter -f "QUAL > 20 & QUAL / AO > 10 & SAF > 0 & SAR > 0 & RPR > 1 & RPL > 1" > 210karyonA_ExtractedReads_mappingToUg99_537ctgRef.filtered.vcf

cat ../210karyonA_ExtractedReads_mappingToUg99_537ctgRef.filtered.vcf |vcffilter -f "TYPE = snp"| vcffilter -f "AC > 0 & AC = 1"|  vcfstats -l > 210karyonA_ExtractedReads_mappingToUg99_537ctgRef.filtered.vcf.hetSNPs.stats.txt
cat ../210karyonA_ExtractedReads_mappingToUg99_537ctgRef.filtered.vcf | vcffilter -f "TYPE = snp"| vcffilter -f "AC > 0 & AC = 2"|  vcfstats -l > 210karyonA_ExtractedReads_mappingToUg99_537ctgRef.filtered.vcf.homoSNPs.stats.txt
cat ../210karyonA_ExtractedReads_mappingToUg99_537ctgRef.filtered.vcf | vcffilter -f "TYPE = snp"|vcffilter -f "AC > 0 "|  vcfstats -l > 210karyonA_ExtractedReads_mappingToUg99_537ctgRef.filtered.vcf.SNPs.stats.txt
