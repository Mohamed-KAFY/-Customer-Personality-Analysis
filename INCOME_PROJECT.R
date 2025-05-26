# Remove all existing objects from the environment
rm(list = ls(all.names = TRUE))

# ----------------------------------------
# Load Income Data
Income <- read.csv(file.choose())   # Choose file manually
View(Income)                        # View the dataset
anyNA(Income)                       # Check for missing values
boxplot(Income)$out                # Display outliers
summary(Income)                     # Summary statistics

# ----------------------------------------
# Working with the Income Column (Y)
attach(Income)                      # Attach data frame
anyNA(Y)                            # Check for missing values in Y
mean(Y, na.rm = TRUE)              # Calculate mean excluding NAs
summary(Y)

# ----------------------------------------
# Impute missing values in Y using the median
library(Hmisc)
c <- impute(Y, median)             # Impute NA with median
summary(c)
boxplot(c)$out
anyNA(c)

# ----------------------------------------
# Detect and remove outliers
lower <- median(c) - 1.5 * IQR(c)  # Lower threshold
upper <- median(c) + 1.5 * IQR(c)  # Upper threshold

# Replace outliers with NA
c1 <- c
c1[c > upper] <- NA
c1[c < lower] <- NA
summary(c1)
boxplot(c1)$out

# Re-impute the outlier NAs with the median
c2 <- impute(c1, median)
summary(c2)
boxplot(c2)$out

# ----------------------------------------
# Save the cleaned income data to a new CSV file
write.csv(c2, "new_income.csv", row.names = FALSE)
