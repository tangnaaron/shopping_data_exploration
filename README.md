# Shopping Data Exploration (UCI Online Shoppers)

This project documents and builds an **analysis-ready** dataset derived from the **UCI Online Shoppers Purchasing Intention** dataset. The pipeline is implemented in R and produces a final dataset with a **random right-censoring** mechanism applied to session duration.

## Project structure

- **Documentation**
  - `shopping/uci_data_documentation.Rmd`: dataset documentation (final dataset first; detailed dataset notes in the Appendix)
  - `shopping/uci_data_documentation.pdf`: rendered PDF output (if already knitted)
- **Code**
  - `shopping/code/00_uci_EDA.Rmd`: exploratory analysis / variable explanations for the raw UCI data
  - `shopping/code/01_uci_data_preprocessing.R`: creates the preprocessed dataset
  - `shopping/code/02_uci_censor_random_time.R`: applies random censoring and writes both intermediate + final outputs
- **Data**
  - `shopping/data/raw_data/uci_shopping.csv`: raw UCI dataset (source)
  - `shopping/data/intermediate_data/01_uci_preprocessed.csv`: preprocessed dataset (adds `TotalDuration`, drops zero-duration rows)
  - `shopping/data/intermediate_data/02_uci_random_censor.csv`: randomly censored intermediate dataset
  - `shopping/data/final_data/shopping_data_final.csv`: **final (analysis-ready) dataset**

## Final dataset

The primary output is:

- `shopping/data/final_data/shopping_data_final.csv`

It contains the preprocessed UCI sessions plus censoring variables:
- `TotalDuration`: total session duration (seconds)
- `TimeThreshold`: row-specific random censoring threshold, sampled uniformly on \([10, 1800]\) seconds
- `CensorTime`: observed time after censoring
- `Censor`: censoring indicator (1 = censored, 0 = fully observed)

For full variable definitions, see `shopping/uci_data_documentation.Rmd` (Section “Final dataset”).

## Reproducing the pipeline

From the project root (R working directory at the repo root), run the scripts in order:

1. Preprocess:
   - `shopping/code/01_uci_data_preprocessing.R`
2. Apply random censoring and write outputs:
   - `shopping/code/02_uci_censor_random_time.R`

These scripts read from `shopping/data/raw_data/` and write to `shopping/data/intermediate_data/` and `shopping/data/final_data/`.

## Rendering the documentation

To render the PDF documentation:

- Open `shopping/uci_data_documentation.Rmd` and Knit to PDF, or run:

```r
rmarkdown::render("shopping/uci_data_documentation.Rmd")
```

## Requirements

- **R** (recent version recommended)
- R packages used in the pipeline/docs:
  - `tidyverse`
  - `here`
  - `knitr`
  - `rmarkdown`
  - `kableExtra`

---

**Note:** This repository is an RStudio project (`Shopping Data Exploration.Rproj`). Paths in scripts/docs use `here::here()` so they resolve relative to the project root.

