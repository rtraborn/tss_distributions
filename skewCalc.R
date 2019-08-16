# function that calculates the skew (third moment) using an unbiased sample estimator
# source: Thiele (1899)
# 	   equation 2.7 (p 24) of Lynch and Walsh
library(e1071)
options(scipen=999)
# current: need to figure out why this returns 2674269 and not ~-2.591599

skewCalc <- function(x) {

	 my.len <- length(x)
	 #print(my.len)
	 n_2 <- (my.len)^2
	 #print(n_2)
	 z_bar <- mean(x)
	 z_bar_2 <- mean(x^2)
	 z_bar_3 <- mean(x^3)
	 z_3_bar <- z_bar^3
	 my_denom <- ((my.len-1)*(my.len-2))
	 #print(my_denom)
	 top_line <- (z_bar_3-(3*z_bar_2*z_bar)+(2*z_3_bar))
	 skew <- (n_2*top_line)/my_denom
	 return(skew)
	 }
	 
	 
