#1. fastQC before trimming
#fastqc ./raw_read_files/*fastq.gz -o ./fastqc_output

#2. fastQC after trimming
fastqc -o ./fastqc_output_post_trimming ./trimming_output/*trimmed.fastq.gz



#PS. how I managed files in SRR directories
#fastQC before trimming 
#for file in /Volumes/Transcend/yvette/downloaded/201-250/complete_ena_files/SRR*/*.{fastq,fastq.gz}; do fastqc $file -o /Volumes/Transcend/yvette/downloaded/201-250/complete_ena_files/fastqc_output; done

