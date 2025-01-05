# Read the csv file with rownames
data_sv <- read.csv("myDataset_severity_lfc_1_DEGs_transposed.csv", row.names=1)



# Remove rownames from the data
rownames(data_sv) <- NULL



# Transform string values of a column
data_sv$severity <- ifelse(data_sv$severity == "severe", 1, ifelse(data_sv$severity == "less-severe", 0, data_sv$severity))

data_sv$severity



# Lastly, write the transformed data to a new csv file
write.csv(data_sv, "myDataset_numerized_severity_lfc_1_DEGs_transposed.csv", row.names=FALSE)


