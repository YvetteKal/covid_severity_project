import pandas as pd

input_file = "gene_matrix_count_R1.csv"
df = pd.read_csv(input_file)


# Sort columns by column names
df.sort_index(axis=1, inplace=True)

print("\nDataFrame after sorting columns by column names:")

# Save sorted DataFrame to CSV
output_file = "gene_matrix_count_R2_dataset.csv"
df.to_csv(output_file, index=False)
print(f"Sorted DataFrame saved to {output_file}")
