#!/bin/bash

log_file="./log_file.txt"

touch "$log_file"

exec > >(tee -a "$log_file") 2>&1

start_time=$(date +%s)

for file in ../trimming_output/*_1_trimmed.fastq.gz; do
    # Get the file name without the "_1_trimmed.fastq.gz" suffix
    sample=$(basename "$file" _1_trimmed.fastq.gz)
    echo "Processing sample: $sample"
    
    # Run HISAT2 for the current sample
    hisat2 -q --rna-strandness FR -x grch38/genome -1 "$file" -2 "${file/_1_/_2_}" | \
    samtools sort -o /Volumes/Transcend/yvette/downloaded/201-250/my\ Project/HISAT2/Bam_files/"$sample"_trimmed.bam
done

end_time=$(date +%s)

# calculate AND print time taken
time_taken=$((end_time - start_time))

echo "HISAT2 finished running!"
echo "Time taken: ${time_taken} seconds."

#PS: in the case some processes failed 
#replaced this code block only
# for file in ../trimming_output/*_1_trimmed.fastq.gz; do
#     # Get the file name without the "_1_trimmed.fastq.gz" suffix
#     sample=$(basename "$file" _1_trimmed.fastq.gz)


#     # check if all output files already exist in the output directory
#     if [ -e "./Bam_files/"$sample"_trimmed.bam" ]; then
#         echo "Skipping ${sample} as it has already been processed."
#         continue
#     fi

#     echo "Processing sample: $sample"
    
#     # Run HISAT2 for the current sample
#     hisat2 -q --rna-strandness FR -x grch38/genome -1 "$file" -2 "${file/_1_/_2_}" | \
#     samtools sort -o ./Bam_files/"$sample"_trimmed.bam
# done



#others

# for file in ../trimming_output/SRR12544660_GSM4753117_COVID_100_74y_female_NonICU_Homo_sapiens_RNA-Seq_1_trimmed.fastq.gz ../trimming_output/SRR12544661_GSM4753118_COVID_101_58y_male_ICU_Homo_sapiens_RNA-Seq_1_trimmed.fastq.gz; do
#     # Get the file name without the "_1_trimmed.fastq.gz" suffix
#     sample=$(basename "$file" _1_trimmed.fastq.gz)
#     echo "Processing sample: $sample"
    
#     # Run HISAT2 for the current sample
#     hisat2 -q --rna-strandness FR -x grch38/genome -1 "$file" -2 "${file/_1_/_2_}" | \
#     samtools sort -o /Volumes/Transcend/yvette/downloaded/201-250/complete_ena_files/HISAT2/Bam_files/"$sample"_trimmed.bam
# done

# echo "HISAT2 finished running!"
