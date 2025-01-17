import pandas as pd
import numpy as np

# real = pd.read_csv('./myDataset_numerized_severity_lfc_1_DEGs_transposed.csv')

# fake = pd.read_csv('./cwgan_beta_severity_lfc_1_nosm_fake_neighbor_vectors_all.csv')

# combined_data = pd.concat([real, fake], ignore_index=True)

# combined_data = pd.DataFrame(combined_data, columns=real.columns)

# combined_data.to_csv('./combined_data/augmented_cwgan_beta_severity_lfc_1_nosm_fake_neighbor_vectors_all.csv', index=False)


#--------------------------
real = pd.read_csv('./myDataset_numerized_severity_lfc_1_DEGs_transposed.csv')


fake = pd.read_csv('./beta_severity_lfc_1_nosm_fake_neighbor_vectors_all.csv')

combined_data = pd.concat([real, fake], ignore_index=True)

combined_data = pd.DataFrame(combined_data, columns=real.columns)

combined_data.to_csv('./combined_data/augmented_beta_severity_lfc_1_nosm_fake_neighbor_vectors_all.csv', index=False)




