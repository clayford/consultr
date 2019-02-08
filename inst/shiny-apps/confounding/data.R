# simulate data based on NHANES data package: https://CRAN.R-project.org/package=NHANES
# generating in this script so we don't have to include NHANES package as an import
set.seed(123)
nh <-
  expand.grid(
    Diabetes = c("No","Yes"),
    SmokingStatus = c("No","Yes"),
    Gender = c("Female","Male"),
    Obese = c("No","Yes"),
    Over50 = c("No","Yes")
  )

# props based on existing NHANES data
prop <- c(0.056,
          0.002,
          0.07,
          0.0005,
          0.075,
          0.002,
          0.11,
          0.004,
          0.03,
          0.005,
          0.056,
          0.004,
          0.04,
          0.005,
          0.04,
          0.003,
          0.07,
          0.009,
          0.035,
          0.004,
          0.09,
          0.023,
          0.05,
          0.01,
          0.03,
          0.02,
          0.013,
          0.008,
          0.05,
          0.024,
          0.017,
          0.006
)

nh <- 
  nh[sample(nrow(nh),size = 1000, replace = T, prob = prop),]
