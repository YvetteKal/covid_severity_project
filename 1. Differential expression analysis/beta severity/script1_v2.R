library(DESeq2)
library(apeglm)

mydata <- read.csv("data/final_count_matrix_R1_no_geneNames.csv", header = T, row.names = 1)
head(mydata)

#experimental design
colData <- read.csv("data/sample_info_v2.csv", row.names = 1) #here, the rownmes in the file must have the same order than in the count matrix. this is to be verified

#Some analysis for excluding healthy control samples from the SEVERITY analysis 
#---------------------------------------------------------------------
rows_to_exclude_severity <- c("NONCOVID_01_54y_female_NonICU","NONCOVID_02_65y_male_ICU","NONCOVID_03_65y_male_ICU","NONCOVID_04_90y_male_NonICU","NONCOVID_05_83y_female_NonICU","NONCOVID_06_75y_female_ICU","NONCOVID_07_50y_male_ICU","NONCOVID_08_53y_female_ICU","NONCOVID_09_49y_female_NonICU","NONCOVID_10_67y_male_ICU","NONCOVID_11_58y_female_NonICU","NONCOVID_12_82y_male_ICU","NONCOVID_13_65y_male_ICU","NONCOVID_14_75y_female_ICU","NONCOVID_15_83y_unknown_ICU","NONCOVID_16_40y_female_ICU","NONCOVID_17_84y_female_ICU","NONCOVID_18_88y_male_ICU","NONCOVID_19_66y_female_ICU","NONCOVID_20_62y_female_ICU","NONCOVID_21_71y_male_NonICU","NONCOVID_22_63y_male_NonICU","NONCOVID_23_42y_female_NonICU","NONCOVID_24_32y_female_NonICU","NONCOVID_25_62y_male_NonICU","NONCOVID_26_36y_male_ICU")


colData <- colData[!(rownames(colData) %in% rows_to_exclude_severity), ]
mydata <- mydata[, !(colnames(mydata) %in% rows_to_exclude_severity)]
#--------------------------------------------------------------------



#make sure the row names in colData matches to column names in myData
all(colnames(mydata) %in% rownames(colData))

#are they also in the same order?
all(colnames(mydata) == rownames(colData))

#link the two files to DESeq or create a deseq2 dataset
dds <- DESeqDataSetFromMatrix(mydata, colData, ~severity)


dds

#Do not consider lowly expressed genes (lowly count reads) since they are hard to measure
#for differential expression (we cant tell the difference between one read and another)
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
dds

#main DESeq
ddsDE <- DESeq(dds)

#extract the normalized read counts produced by DESeq
normCounts <- counts(ddsDE, normalized = T)
write.csv(normCounts, "data/final_count_matrix_R1_severity_normalized.csv")

#results
res <- results(ddsDE, alpha = 0.01) #alpha is the corrected p-value

#look at the summary of our res or summarise the output of the result file: %up and downs regulations
summary(res)

#to see more details
#res


# Order the res object by adjusted p-values (increasing)
res_ordered <- res[order(res$padj), ]

# Filter res to display only upregulated and downregulated genes
#up_down_res <- res_ordered[res_ordered$log2FoldChange >= 2 | res_ordered$log2FoldChange <= -2, ]


#order res by the most significant gene with adjusted p-value (increasing)
#output DESeq results
#res0.01Ordered <- res0.01[order(res0.01$padj),]
write.csv(res_ordered, "data/final_count_matrix_R1_severity_normalized_deseq-results-ordered.csv")


#look at the conditions: the first one is the first shown
resultsNames(ddsDE)
#negative LFC:more expression in second condition and positive: more expression in the first condition

#visualization
#1. plotMA puts the mean expression on the x and the lfc in y
#and the color code gives the significance based on the p-value in blue

pdf("data/myplotMa_severity.pdf", width=8, height=6) 

plotMA(ddsDE, ylim = c(-5, 5))
dev.off()  # Close the PDF device. a pdf called myplot.pdf has been created with deg in blue..
#the up regulated in the first condition are up the bar and the upregulated in the second are down the bar with lfc negative.



