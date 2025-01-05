#splitting the data into two groups based on the HFD-45 values
df <- read.csv("data/cond_2.csv", header = T)

df$condition <- ifelse(df$condition < 26, "severe", "less-severe")

write.csv(df, file = "data/cond_2_modified.csv", row.names = FALSE)
