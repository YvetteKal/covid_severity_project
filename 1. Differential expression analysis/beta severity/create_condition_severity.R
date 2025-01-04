# read the original csv file into R as a data frame
df <- read.csv("data/cond_2.csv", header = T)

# replace values in the second column based on criteria
df$condition <- ifelse(df$condition < 26, "severe", "less-severe")

# lastly, write the modified data frame to a new csv file
write.csv(df, file = "data/cond_2_modified.csv", row.names = FALSE)
