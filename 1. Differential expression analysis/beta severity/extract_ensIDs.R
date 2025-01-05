#retrieve ensembl_ids alone from my DESeq2 results

results <- read.csv("data/final_count_matrix_R1_severity_normalized_deseq-results-ordered.csv", row.names = 1)


# Extracting Ensembl gene IDs from DESeq2 results
ensembl_ids <- rownames(results)

# Removing anything that comes after the symbol "_" in the Ensembl gene IDs
ensembl_ids_ <- gsub("_.*", "", ensembl_ids)
write.csv(ensembl_ids_, file = "data/all_ensemble_ids.csv", row.names = FALSE)

# Use grep to extract Ensembl IDs that end with "_na"
ensembl_ids_na <- ensembl_ids[grep("_noName$", ensembl_ids)]
ensembl_ids_na <- gsub("_.*", "", ensembl_ids_na)
write.csv(ensembl_ids_na, file = "data/na_ensemble_ids.csv", row.names = FALSE)
