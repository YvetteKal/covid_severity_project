#---------------------next------------
#Augmented with CGAN and CWGAN dtaset dataset--
file1 <- read.csv("data/the_215_final_overlaping_severity_biomarkers.csv", header = TRUE)

file2 <- read.csv("data/myDataset_numerized_severity_lfc_1_DEGs_transposed.csv", header = TRUE)

subset <- file1[, 1, drop = FALSE]

# transpose the data frame
file2_transposed_sv <- t(file2)

library(tibble)
file2_transposed_sv <- as.data.frame(file2_transposed_sv)

df <- tibble::rownames_to_column(file2_transposed_sv, "X")


#merge based on Gene_symbols variable
merged_data <- merge(subset, df, by = "X")

#transpose back
merged_data <- t(merged_data)

write.csv(merged_data, "data/myDataset_numerized_severity_lfc_1_DEGs_transposed_biomarkers_only.csv", row.names = FALSE)
