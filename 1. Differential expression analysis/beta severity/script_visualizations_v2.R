library(ggplot2)
library(pheatmap)
library(dplyr)
library(AnnotationDbi)
library(org.Hs.eg.db)


normCounts_ <- read.csv("data/final_count_matrix_R1_severity_normalized.csv", row.names = 1)
deseqRes_ <- read.csv("data/final_count_matrix_R1_severity_normalized_deseq-results-ordered.csv", row.names = 1)

sample_conditions <- read.csv("data/sample_info_v2.csv", row.names = 1)

# Adding another column to the results to tell if yes or no the padjis<0.01
deseqRes_$sig <- ifelse(deseqRes_$log2FoldChange > 1 & deseqRes_$padj <= 0.01, "up",
                        ifelse(deseqRes_$log2FoldChange < -1 & deseqRes_$padj <= 0.01, "down", "not_sig"))


deseqRes_$symbol <-mapIds(org.Hs.eg.db, keys = rownames(deseqRes_), keytype = "ENSEMBL", column = "SYMBOL")



# Some visualizations
# Remove the outliers (or the NAs)
deseqRes_ <- na.omit(deseqRes_)
write.csv(deseqRes_, "data/final_count_matrix_R1_severity_lfc_1_normalized_deseq-results-ordered_sigAdded_noNAs.csv")

summary_table <- table(deseqRes_$sig)

# Get counts for each category
up_count <- summary_table["up"]
down_count <- summary_table["down"]
not_sig_count <- summary_table["not_sig"]

# Convert 'sig' column to a factor with correct levels, up, down or not_sig
deseqRes_$sig <- factor(deseqRes_$sig, levels = c("up", "down", "not_sig"))

# 1. ggplot plotMA
ggplot(deseqRes_, aes(x = log10(baseMean), y = log2FoldChange, color = sig)) +
  geom_point() +
  scale_color_manual(name = "Gene severity",
                     values = c("up" = "red", "down" = "blue", "not_sig" = "gray"),
                     labels = c(paste("Up (n =", up_count, ")"),
                                paste("Down (n =", down_count, ")"),
                                paste("Not Significant (n =", not_sig_count, ")")))

# 2. Volcano plot
volcano_plot <- ggplot(deseqRes_, aes(x = log2FoldChange, y = -log10(padj), color = sig)) + 
  geom_point() +
  scale_color_manual(name = "Gene severity",
                     values = c("up" = "red", "down" = "blue", "not_sig" = "gray"),
                     labels = c(paste("Up (n =", up_count, ")"),
                                paste("Down (n =", down_count, ")"),
                                paste("Not Significant (n =", not_sig_count, ")")))

print(volcano_plot)

#3. GENERAL heatmaps: only consider differentailly expressed genes: the yes, the up and down regulated and the most regulated
#but we know the yes are not in the normalized_counts file
#so we need to merge the two files into another
signi <- subset(deseqRes_, padj <= 0.01 & abs(log2FoldChange) >= 1) #gives total row minus omitted rows
#typical RNA-seq experiment, genes with higher baseMean values are generally more abundantly expressed across all samples, 
#while genes with lower baseMean values are less abundantly expressed
#The baseMean provides an estimate of the overall expression level of a gene across all samples, 
#and it can be used as a criterion to identify genes that are more likely to be differentially expressed
#merge signi and normcounts_ by rownames
allsig <- merge(normCounts_, signi, by = 0)

sigCounts <- allsig[, 2:101]


row.names(sigCounts) <- allsig$Row.names


pheatmap(log2(sigCounts + 1), scale = 'row', show_rownames = F,show_colnames = F, treeheight_row = 0,annotation = dplyr::select(sample_conditions, severity))


#PARTIAL  heatmap
# Filter the 'deseqRes_' based on padj <= 0.01
signi <- subset(deseqRes_, padj <= 0.01 & abs(log2FoldChange) >= 1) 

# Sort the 'signi' subset based on the absolute value of log2foldchange
signi <- signi[order(abs(signi$log2FoldChange), decreasing = TRUE),]

# Select the top 10 most differentially expressed genes
top_10_de_genes <- head(signi, 10)

# Extract the rownames from the 'top_10_de_genes' and merge with 'normCounts_'
#rownames_top_10 <- rownames(top_10_de_genes)
#sigCounts <- normCounts_[rownames_top_10, ]
write.csv(top_10_de_genes, "data/top_10_de_genes_severity_deseq-results.csv")


allsig <- merge(normCounts_, top_10_de_genes, by = 0)

sigCounts <- allsig[, 2:101]


#row.names(sigCounts) <- allsig$Row.names AND  #top_10_de_genes$symbol
row.names(sigCounts) <- allsig$Row.names


# Convert the vector to a matrix with a single column to use as an annotation.
annotation_matrix <- data.frame(severity = sample_conditions$severity)

# Assuming 'sample_conditions' is a data frame containing condition information for each sample
# Here, we are assuming 'sample_conditions$severity' is a vector representing the condition/severity for each sample.
# If it's not, replace it with the appropriate column or vector from the 'sample_conditions' data frame.
heatmap_object <-pheatmap(log2(sigCounts + 1), scale = 'row', show_rownames = T, show_colnames = F, annotation = dplyr::select(sample_conditions, severity), border_color = "black")


# Save the heatmap as an image
ggsave("data/partial_heatmap_severity.png", plot = heatmap_object)

