#!/bin/bash

# set the output directory
output_dir=./trimming_output

# Specify the log file path and name
log_file="${output_dir}/log_file.txt"

# Create the log file (if it doesn't exist)
touch "$log_file"

# Redirect stdout and stderr to log file
exec > >(tee -a "$log_file") 2>&1

# capture start time
start_time=$(date +%s)
    
# loop over all paired-end read files in the input directory
for file in ./raw_read_files/*_1.fastq.gz; do

    # get the basename of the file
    filename=$(basename "${file}" _1.fastq.gz)

    # set the forward and reverse read filenames
    forward_reads=./${filename}_1.fastq.gz
    reverse_reads=./${filename}_2.fastq.gz

        # set the output filenames
    trimmed_forward=${output_dir}/${filename}_1_trimmed.fastq.gz #Output file that contains surviving pairs from the _1 file
    unpaired_forward=${output_dir}/${filename}_1_unpaired.fastq.gz #Output file that contains surviving orphans from the _1 file
    trimmed_reverse=${output_dir}/${filename}_2_trimmed.fastq.gz #Output file that contains surviving pairs from the _2 file
    unpaired_reverse=${output_dir}/${filename}_2_unpaired.fastq.gz #Output file that contains surviving orphans from the _2 file

        # run Trimmomatic on the file
    java -jar /Users/yvette/Documents/Nairobi/Thesis/softwares/Trimmomatic-0.39/trimmomatic-0.39.jar PE -phred33 \
        "${forward_reads}" "${reverse_reads}" \
        "${trimmed_forward}" "${unpaired_forward}" \
        "${trimmed_reverse}" "${unpaired_reverse}" \
        ILLUMINACLIP:/Users/yvette/Documents/Nairobi/Thesis/softwares/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
        LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

done

# capture end time
end_time=$(date +%s)

# calculate time taken
time_taken=$((end_time - start_time))

echo "Trimmomatic finished running!!"
echo "Time taken: ${time_taken} seconds."


#PS: the code I ran if trimming failed for some files

# #!/bin/bash

# # set the output directory
# output_dir=./trimming_output

# # capture start time
# start_time=$(date +%s)


# # loop over all paired-end read files in the input directory
# for file in ./raw_read_files/*_1.fastq.gz; do

#     # get the basename of the file
#     filename=$(basename "${file}" _1.fastq.gz)

#     # check if all output files already exist in the output directory
#     if [ -e "${output_dir}/${filename}_1_trimmed.fastq.gz" ] && \
#        [ -e "${output_dir}/${filename}_2_trimmed.fastq.gz" ] && \
#        [ -e "${output_dir}/${filename}_1_unpaired.fastq.gz" ] && \
#        [ -e "${output_dir}/${filename}_2_unpaired.fastq.gz" ]; then
#         echo "Skipping ${filename} as it has already been processed."
#         continue
#     fi

#     # set the forward and reverse read filenames
#     forward_reads=./raw_read_files/${filename}_1.fastq.gz
#     reverse_reads=./raw_read_files/${filename}_2.fastq.gz

#     # set the output filenames
#     trimmed_forward=${output_dir}/${filename}_1_trimmed.fastq.gz
#     unpaired_forward=${output_dir}/${filename}_1_unpaired.fastq.gz
#     trimmed_reverse=${output_dir}/${filename}_2_trimmed.fastq.gz
#     unpaired_reverse=${output_dir}/${filename}_2_unpaired.fastq.gz

#     # run Trimmomatic on the file
#     java -jar /Users/yvette/Documents/Nairobi/Thesis/softwares/Trimmomatic-0.39/trimmomatic-0.39.jar PE -phred33 \
#         "${forward_reads}" "${reverse_reads}" \
#         "${trimmed_forward}" "${unpaired_forward}" \
#         "${trimmed_reverse}" "${unpaired_reverse}" \
#         ILLUMINACLIP:/Users/yvette/Documents/Nairobi/Thesis/softwares/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
#         LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

# done

# # capture end time
# end_time=$(date +%s)

# # calculate time taken
# time_taken=$((end_time - start_time))

# # print time taken
# echo "Trimmomatic finished running!"
# echo "Time taken: ${time_taken} seconds."

