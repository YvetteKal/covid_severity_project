#Augmented with CGAN and CWGAN dtaset dataset--
file1 <- read.csv("data/beta_severity_lfc_1_optimal_features_before_DA.csv", header = TRUE)

file2 <- read.csv("data/myDataset_numerized_severity_lfc_1_DEGs_transposed.csv", header = TRUE)

subset <- file1[, 1, drop = FALSE]

# transpose the data frame
file2_transposed_sv <- t(file2)

library(tibble)
file2_transposed_sv <- as.data.frame(file2_transposed_sv)

df <- tibble::rownames_to_column(file2_transposed_sv, "X")


# Merge the two data frames based on the Gene_symbols variable
merged_data <- merge(subset, df, by = "X")

#transpose back
merged_data <- t(merged_data)

# Write the selected rows to a new CSV file
write.csv(merged_data, "data/myDataset_numerized_severity_lfc_1_DEGs_transposed_SF_only.csv", row.names = FALSE)
