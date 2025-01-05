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
  - Evaluates data quality using statistical tests and machine learning classifiers.

### Evaluation

- **Methods**:
  - Statistical metrics (e.g., mean, variance comparison)
  - Model performance metrics (e.g., accuracy, precision, recall)
  - Identifies the top 5 most relevant genes for biomarker discovery.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/<username>/differential-expression-pipeline.git
   cd differential-expression-pipeline
   ```

2. Install dependencies:

   ```bash
   pip install -r requirements.txt
   ```

3. Ensure bioinformatics tools (FastQC, MultiQC, Trimmomatic, HISAT2, featureCounts) are installed and added to your system's PATH.

## Usage

1. **Prepare Input Data**: Organize raw RNA-Seq files in `data/raw`.
2. **Run the Pipeline**:
   ```bash
   python main_pipeline.py
   ```
3. **Outputs**:
   - Quality control reports
   - Aligned BAM files
   - Gene expression matrices
   - Synthetic data samples
   - Feature importance and selected biomarkers

## Repository Structure

```
.
├── data
│   ├── raw          # Raw RNA-Seq data
│   ├── processed    # Processed data outputs
│   └── augmented    # Synthetic data outputs
├── scripts          # Core pipeline scripts
├── models           # Machine learning and GAN models
├── results          # Analysis results (e.g., top genes, evaluation metrics)
├── requirements.txt # Python dependencies
├── README.md        # Project documentation
└── LICENSE          # License file
```

## Dependencies

- Python (>=3.8)
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

