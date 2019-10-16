#!/bin/bash -l
#PBS -l nodes=1:ppn=2,walltime=1:00:00
#PBS -m abe
#PBS -M lixx3627@umn.edu


cd $PBS_O_WORKDIR

# run NCBI blast using ug99_falcon assembly

module load ncbi_blast+
export BLASTDB=/home/figueroa/shared/Analysis/ug99_Jan/blast/db/nt


# using the downloaded NCBI nt db
# only get the top 10 hits
blastn -query /home/figueroa/lixx3627/Analysis/canu/ug99_PB_ALL_170m/ug99_PB_ALL_170m.contigs.fasta -db /panfs/roc/scratch/lixx3627/blast/nt -out ug99_170m_
10hits.fasta.out -outfmt 0 -evalue 1e-10 -show_gis -num_alignments 10 -num_threads 24


# in the case of using customized db

makeblastdb -in all_p_ctg.fa -parse_seqids -dbtype 'nucl' -out ug99_unzip_p
blastn -query AvrSr50_CDS_210_98.fasta -db ug99_unzip_p -out ug99_unzip_AvrSr50.fasta.out -outfmt 0 -show_gis -num_threads 6

makeblastdb -in 210V2AP2.fasta -parse_seqids -dbtype 'nucl' -out 210V2AP2
# blast to find mating types genes (use transcript as query) in ug99 and 210 and see which haplotype these genes are
blastn -query pgt_2STE3_and_2HD.fa -db ug99_canu_2Xpilon -out pgt_2STE3_and_2HD_transcript_in_ug99.fasta.out -outfmt 0 -show_gis -num_threads 6 -num_alignments 10
blastn -query pgt_2STE3_and_2HD.fa -db 210V2AP2 -out pgt_2STE3_and_2HD_transcript_in_210.fasta.out -outfmt 0 -show_gis -num_threads 6 -num_alignments 10

# blast to find mating types genes (use gene coordinates instead of trasncripts only as query) in ug99 and 210 and see which haplotype these genes are   
blastn -query mating_genes.fa -db Ug99V2AP2_537ctg -out mating_genes_in_ug99afterBP.fasta.out -outfmt 0 -show_gis -num_threads 6 -num_alignments 10                        
blastn -query mating_genes.fa -db 210V2AP2_446ctgs -out mating_genes_in_210afterBO.fasta.out -outfmt 0 -show_gis -num_threads 6 -num_alignments 10


