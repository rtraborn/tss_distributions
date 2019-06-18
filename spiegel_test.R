spiegel_test <- function(x) {
library(VGAM)
library(pracma)
# compute pvalue under null of x normally distributed;
# x should be a vector;
xm <- mean(x);
xs <- std(x);
xz <- (x - xm) / xs;
print(xz)
xz2 <- xz ^2;
N <- sum(xz2 * log(xz2));
n <- length(x);
ts <- (N - 0.73 * n) / (0.8969 * sqrt(n)); #under the null, ts ~ N(0,1)
print(ts)
pval <- (1 - abs(erf(ts / sqrt(2)))); 
return(pval)
}