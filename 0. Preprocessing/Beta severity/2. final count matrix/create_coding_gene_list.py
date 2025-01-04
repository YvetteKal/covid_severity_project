import gzip

# Define the path to the GTF file
gtf_file = 'Homo_sapiens.GRCh38.106.gtf.gz'

# Create an empty set to store the non-coding gene IDs
coding_genes = set()

# Loop through the lines in the GTF file
with gzip.open(gtf_file, 'rt') as f:
    for line in f:
        # Skip over any header lines
        if line.startswith('#'):
            continue
        # Split the line into fields
        fields = line.strip().split('\t')
        # Check if this is a gene feature
        if fields[2] == 'gene':
            # Extract the attributes as a dictionary
            attributes = dict(x.strip().split(' ') for x in fields[8].split(';') if x.strip())
            # Extract the gene ID and biotype
            gene_id = attributes['gene_id'].strip('"')
            biotype = attributes['gene_biotype'].strip('"')
            # Check if this is a non-coding gene
            if biotype == 'protein_coding':
                coding_genes.add(gene_id)

# Print the total number of non-coding genes found
print(f"Total number of non-coding genes: {len(coding_genes)}")

# Print the first 10 non-coding gene IDs
print("First 10 non-coding gene IDs:")
for gene_id in list(coding_genes)[:10]:
    print(gene_id)

# Save the list of non-coding genes to a file
with open('protein_coding_genes.txt', 'w') as f:
    f.write('\n'.join(list(coding_genes)))
    
