# Feng Li
# Generate genome coverage from WGS data. Result: a coverage distributation plot to check coverage uniformity. x-axis coverage and y-axis read quantity

library(ggplot2)
library("data.table") # use fread to speed up reading files
library(tidyverse)

# 1. first generate genome-wide coverage using bedtools genomecov
# bedtools genomecov -ibam INPUT.BAM -bg > coverage.txt
# sort -k1,1 -k2,2n coverage.txt > sorted_coverage.txt

# 2. Plot genome coverage distributation. For example, check if genome coverage is uniform from a sequencing technology like Pacbio
sample_bgh <- "/path/to/sorted_coverage.txt"
bgh <- fread(sample_bgh, sep = "\t", header = FALSE, col.names = c("chr", "start", "end", "cov"))

# Generate the coverage plot
#test <- bgh[bgh$chr == "1",]
 cov_plot <- bgh %>%
  filter(cov < 80) %>% # several bases can be with extreme coverage
  group_by(cov) %>%
  mutate(cov_bases = end -start) %>%
  summarise(sum_bases = sum(cov_bases)) %>%
  ggplot(aes(x = cov, y = sum_bases)) +
  geom_bar(stat = "identity") +
  labs(x = "Coverage", y = "Number of Reads") +
  ggtitle("Coverage Distribution") +
  theme_classic()

cov_plot
