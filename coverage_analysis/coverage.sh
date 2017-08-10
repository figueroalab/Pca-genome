#Using bedtools 2.25
#Illumina short reads (100bp PE) were mapped to the reference genomes with BWA-MEM (0.7.12) with default parameters.
#Resulting sam files were sorted and converted to bam with samtools (1.3).
#Bam files were converted to bed with  bedtools bamtobed -i <BAM> > output.bed
#Then, the bed files were sorted as recommended by bedtools (-k1,1 -k2,2n)

#To find non-bubble regions (collapsed) in the primary contigs
bedtools complement -i 12nc29.syntany.coords.p.sorted.bed -g 12nc29.p.chromlen > 12nc29.collapsed.coords.p.bed
bedtools complement -i 12sd80.syntany.coords.p.sorted.bed -g 12sd80.p.chromlen > 12sd80.collapsed.coords.p.bed

#Coverage of bubble (aka haplotig) regions
bedtools coverage -mean -sorted -g 12nc29.chromlen -a 12nc29.syntany.coords.p.sorted.bed -b nc29_illumina_to_ncref.sorted.bam.bed.sort > 12nc29.p.bubble.cov
bedtools coverage -mean -sorted -g 12sd80.chromlen -a 12sd80.syntany.coords.p.sorted.bed -b sd80_illumina_to_sdref.sorted.bam.bed.sort > 12sd80.p.bubble.cov
bedtools coverage -mean -sorted -g 12nc29.chromlen -a 12nc29.syntany.coords.h.sorted.bed -b nc29_illumina_to_ncref.sorted.bam.bed.sort > 12nc29.h.bubble.cov
bedtools coverage -mean -sorted -g 12sd80.chromlen -a 12sd80.syntany.coords.h.sorted.bed -b sd80_illumina_to_sdref.sorted.bam.bed.sort > 12sd80.h.bubble.cov

#Coverage of collapsed regions in primary contigs
bedtools coverage -mean -sorted -g 12nc29.chromlen -a 12nc29.collapsed.coords.p.bed -b nc29_illumina_to_ncref.sorted.bam.bed.sort > 12nc29.p.collapsed.cov
bedtools coverage -mean -sorted -g 12sd80.chromlen -a 12sd80.collapsed.coords.p.bed -b sd80_illumina_to_sdref.sorted.bam.bed.sort > 12sd80.p.collapsed.cov

#Plot coverage histograms with R script.
