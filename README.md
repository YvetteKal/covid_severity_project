# covid_severity_project
# Differential Expression and Biomarker Identification Pipeline

This repository contains the complete pipeline for differential expression analysis and biomarker identification using RNA-Seq data. The pipeline includes quality control, trimming, alignment, quantification, feature selection, data augmentation using generative adversarial networks, and evaluation of key features.

## Table of Contents

1. [Overview](#overview)
2. [Pipeline Components](#pipeline-components)
   - [Quality Control](#quality-control)
   - [Trimming](#trimming)
   - [Alignment](#alignment)
   - [Quantification](#quantification)
   - [Feature Selection and Machine Learning](#feature-selection-and-machine-learning)
   - [Data Augmentation](#data-augmentation)
   - [Evaluation](#evaluation)
   - [Top 5 biomarkers](#Top-5-biomarkers)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Repository Structure](#repository-structure)
6. [Dependencies](#dependencies)
7. [Contributing](#contributing)
8. [License](#license)

---

## Overview

This pipeline was designed to identify biomarkers for determining the severity of SARS-CoV-2 Beta infections using RNA-Seq data. It integrates traditional bioinformatics workflows with modern machine learning techniques to enhance data analysis and biomarker discovery.

## Pipeline Components

### Quality Control

- **Tools**: FastQC, MultiQC
- **Description**: Assesses the quality of raw RNA-Seq data and compiles a comprehensive quality report.

### Trimming

- **Tools**: Trimmomatic
- **Description**: Removes low-quality bases and adapter sequences to ensure clean reads for downstream analysis.

### Alignment

- **Tools**: HISAT2
- **Description**: Aligns trimmed reads to the reference genome to produce BAM files for gene expression quantification.

### Quantification

- **Tools**: featureCounts
- **Description**: Counts aligned reads per gene to generate a gene expression matrix.

### Feature Selection and Machine Learning

- **Tools**: scikit-learn (RFECV, Random Forests)
- **Description**:
  - Feature selection using Recursive Feature Elimination with Cross-Validation (RFECV) to identify important genes.
  - Random Forest model training to evaluate gene importance and predict outcomes.

### Data Augmentation

- **Tools**: GAN, conditional Wasserstein GAN with Gradient Penalty (cWGAN-GP)
- **Description**: Enhances the dataset by generating synthetic samples:

### Evaluation

- **Methods**:
  - Evaluates data quality using statistical tests and machine learning classifiers.
  - Statistical metrics (e.g., mean, variance comparison, distributions with PCA, t-SNE, and UMAP)
  - Model performance metrics (e.g., accuracy, precision, recall (sensitivity), specificity)

### Top 5 biomarkers

- **Methods**:
  - Identifies the top 5 most important genes for biomarker discovery.

## Installation

1. Clone the repository:

   ```bash
   git https://github.com/YvetteKal/covid_severity_project.git
   change the files paths to yours
   ```

2. Install dependencies:

   ```bash
   pip install -r requirements.txt
   ```

3. Ensure bioinformatics tools (FastQC, MultiQC, Trimmomatic, HISAT2, featureCounts) are installed and added to your system's PATH.



## Repository Structure
```
├── covid_severity_project
    ├── 0. Preprocessing
        ├── Beta severity
            ├── 1. quality control_trimming_alignment_quantification
                ├── log_file_mapping.txt
            ├── 2. final count matrix
                ├── merge.py
                ├── protein_coding_genes.txt
                ├── sort_columns.py
                ├── log_file_quantification.txt
                ├── ENS2genename.txt
                ├── create_coding_gene_list.py
                ├── filter_coding_genes.py
    ├── 1. Differential expression analysis
        ├── beta severity
            ├── create_condition_severity.R
            ├── script1_v2.R
            ├── extract_ensIDs.R
            ├── script_visualizations_v2.R
            ├── PCA_batch_analysis.ipynb
            ├── data
                ├── ENS2genename.txt
    ├── 2. Gene ontology DEGs
        ├── SRPLOT
            ├── beta
                ├── severity
                    ├── 2d774e6a1cb4d583
                        ├── go.2d774e6a1cb4d583
                            ├── 8b08fe5b80bd7795.txt
    ├── 3. Feature selection before data augmentation
        ├── 1. beta_severity_lfc_1_optimal_features_before_DA.ipynb                    
    
    ├── 4. Data augmentation
        ├── 2. feature selection and evaluation before data augmentation
            ├── select_optimal_features_in_datasets.R
            ├── numerize_conditions.R
        ├── 3. data augmentation and evaluation
            ├── 2. Evaluation
                ├── cumsums
            ├── 1. DA
                ├── 1.1.CGAN_beta_severity_lfc_1_cosine_pca_all_no_smote_all.ipynb
                ├── 1.2.cw-GAN-GP_beta_severity_lfc_1_cosine_pca_all_no_smote_all.ipynb
    ├── 5. Feature selection after data augmentation
        ├── 1. fake data
            ├── beta severity
                ├── combine_datasets.py
        ├── 2. optimal features
                ├── 3. optimal-genes-evaluation-after_DA_original_set_before-GO_okay.ipynb
                ├── 2.cwgan_beta_severity_lfc_1_nosm_optimal_features_after_DA.ipynb
                ├── 1.cgan_beta_severity_lfc_1_nosm_optimal_features_after_DA.ipynb
                ├── 5. optimal-genes-evaluation-after_DA_cwgan_before-GO_okay.ipynb
                ├── 4.optimal-genes-evaluation-after_DA_cgan_before-GO_okay.ipynb
        ├── 4. final_overlaps_optimal_biomarkers_evaluation
            ├── 3. optimal-genes-evaluation-after_DA_original_set_before-GO_okay.ipynb
            ├── select_biomarkers.R
            ├── 5. optimal-genes-evaluation-after_DA_cwgan_before-GO_okay.ipynb
            ├── 4.optimal-genes-evaluation-after_DA_cgan_before-GO_okay.ipynb       
    ├── 6. Gene ontology Biomarkers
        ├── SRPlot
            ├── up only
                ├── 21b4142731c2f691
            ├── All
                ├── 4608518ad69d7907
            ├── down only
                ├── f702aefa1ad46b26
            ├── select_final_overlaping_markers.R
    ├── 7. Primary study information
        ├── metadata
            ├── GSE157103_series_matrix.txt
    ├── README.md        # Project documentation
    ├── LICENSE          # License file

    

        
                        
```

The data and models for this project are available on request due to Github size limitations:
├── data
│   ├── raw          # Raw RNA-Seq data
│   ├── processed    # Processed data outputs
│   └── augmented    # Synthetic data outputs
├── models           # Machine learning and GAN models


## Dependencies

- Python (=3.10)
- FastQC
- MultiQC
- Trimmomatic
- HISAT2
- featureCounts
- scikit-learn
- TensorFlow (for GANs)

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your improvements.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

Happy analyzing! If you have any questions, feel free to open an issue.

