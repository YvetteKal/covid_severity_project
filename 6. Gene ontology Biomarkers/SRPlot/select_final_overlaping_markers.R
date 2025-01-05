file2 <- read.csv("data/final_count_matrix_R1_severity_lfc_1_normalized_deseq-results-ordered_sigAdded_noNAs.csv", header = TRUE)

file1 <- read.csv("data/the_215_final_overlaping_severity_biomarkers.csv", header = TRUE)


# Merge the two data frames based on the symbol variable
merged_data <- merge(file1, file2, by = "symbol")

write.csv(merged_data, "data/215_severity_biomarkers_lfc_1_DEGSeqResults.csv", row.names = FALSE)