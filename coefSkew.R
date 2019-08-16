# function that calculates the coefficient of skewness, as described in
# equation 2.8 (p 24) of Lynch and Walsh

library(e1071)
options(scipen=999)

coefSkew <- function(x, skew.type=3) {

	 if (any(ina <- is.na(x))) {
	    if (na.rm)
	       x <- x[!ina]
	    else return(NA)
	    }	 

	 sk <- skewness(x, type=skew.type)
	 v <- var(x)^(3/2)
	 coef <- sk/v

	 return(coef)
	 }
	 
	 
