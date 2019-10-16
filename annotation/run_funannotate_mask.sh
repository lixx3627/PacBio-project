Funannotate

# MSI Nick installed the version 1.5.0 successfully on Sept 25 2018

#!/bin/bash -l

#PBS -l nodes=1:ppn=20,walltime=40:00:00
#PBS -m abe
#PBS -M lixx3627@umn.edu

cd $PBS_O_WORKDIR

#Using version 1.5.0
module load funannotate/1.5.0

# To start with annotation, first sort the assembly contigs from the largest to smallest
#Using version 1.5.0
module load funannotate/1.5.0
# run repeat mask for ug99 537 contigs after decontamination and well as break chimeric contig and rename them
cat Ug99V2AP2_537ctg.fa | sed 's/^>Ug99V2_/>/g' > Ug99V2AP2_537ctg_shortN.fa
cat Ug99V2AP2_537ctg_shortN.fa | bioawk -c fastx '{ print length($seq), ">"$name, $seq }' |sort -k1,1nr | cut -f2,3 | tr "\t" "\n" > Ug99V2AP2_537ctg_shortN_sorted.fa
funannotate mask -i Ug99V2AP2_537ctg_shortN_sorted.fa -o Ug99V2AP2_537ctgs_mask.fa --cpus 20
