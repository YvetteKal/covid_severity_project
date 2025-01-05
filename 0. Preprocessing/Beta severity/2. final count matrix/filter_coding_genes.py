import pandas as pd

count_matrix = pd.read_csv('gene_matrix_count_R1_dataset.csv', index_col=0)

# Read in a list of non-coding gene IDs 
with open('protein_coding_genes.txt', 'r') as f:
    coding_genes = [line.strip() for line in f]

# Subset the count matrix to keep only protein-coding genes
count_matrix = count_matrix.loc[count_matrix.index.isin(coding_genes)]

count_matrix.to_csv('gene_matrix_count_R1_dataset_no_non_coding.csv')
