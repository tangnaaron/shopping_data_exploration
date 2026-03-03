library(tidyverse)
library(ggplot2)
library(here)

work_dir <- here()
uci_data <- read_csv(file.path(work_dir, "shopping", "data", "intermediate_data", "01_uci_preprocessed.csv"))

# Introducing censorship with random time across columns
set.seed(123)
time_threshold <- runif(nrow(uci_data), min = 10, max = 1800) # random time threshold is between 30 and 60 min

uci_transformed <- uci_data %>%
  mutate(TimeThreshold = time_threshold, # different time threshold for every row 
         CensorTime = ifelse(TotalDuration >= time_threshold, time_threshold, TotalDuration), # time with censoring
         Censor = ifelse(TotalDuration >= time_threshold, 1, 0)) # censor indicator

# Visualizing censorship
uci_transformed %>%
  group_by(Censor) %>%
  summarize(n = n())

write.csv(uci_transformed, file.path(work_dir, "shopping", "data", "intermediate_data", "02_uci_random_censor.csv"),
          row.names = FALSE)

write.csv(uci_transformed, file.path(work_dir, "shopping", "data", "final_data", "shopping_data_final.csv"),
          row.names = FALSE)

