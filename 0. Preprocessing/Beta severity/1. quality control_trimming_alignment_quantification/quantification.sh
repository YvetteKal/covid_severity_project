#!/bin/bash

# # STEP 3: Run featureCounts for Quantification
# # get the gtf if its not on the local computer
#wget http://ftp.ensembl.org/pub/release-106/gtf/homo_sapiens/Homo_sapiens.GRCh38.106.gtf.gz

log_file="./log_file.txt"

# or create the log file if it doesn't exist
touch "$log_file"

# Redirect the standard output to the log file
exec > >(tee -a "$log_file") 2>&1

start_time=$(date +%s)


for file in ../HISAT2/Bam_files/*.bam; do
    # Get the file name without the "_trimmed.bam" suffix
    sample=$(basename "$file" _trimmed.bam)
    echo "Processing sample: $sample"

    featureCounts -p -a Homo_sapiens.GRCh38.106.gtf.gz -o ./quants/"$sample"_counts.txt "$file"
    
done

end_time=$(date +%s)

time_taken=$((end_time - start_time))

echo "featureCounts finished running!"
echo "Time taken: ${time_taken} seconds."

#PS: quantification exon specific. we just changed the line but it gave the same results as in R1
    #featureCounts -p -t exon -a Homo_sapiens.GRCh38.106.gtf.gz -o ./counts/"$sample"_counts.txt "$file"
