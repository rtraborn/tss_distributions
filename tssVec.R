tssVec <- function(x) { 
       vec.len <- nrow(x)
       my.vec <- vector(mode="numeric", length=0)
       for (i in 1:vec.len) {
       	   this.vec <- rep(x$start[i], x$score[i])
	   my.vec <- c(my.vec, this.vec)
	   }
return(my.vec)
}