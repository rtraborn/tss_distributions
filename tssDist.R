tssDist <- function(tssFile, tsrFile,  minTAGs=10, write.file=TRUE, fileOut="tssDist_out_0708.txt") { 
	source("tssVec.R")
	library(GenomicRanges)
	library(e1071)
	
	tss <- read.table(file=tssFile, header=FALSE)
	colnames(tss) <- c("seq", "start", "end", "ID", "nTAGs", "strand")
	tssGR <- GRanges(seqnames=tss$seq, IRanges(tss$start, tss$end), strand=tss$strand, score=tss$nTAGs)
	tsr <- read.table(file=tsrFile, header=TRUE)
	tsrGR <- GRanges(seqnames=tsr$seq, IRanges(tsr$start, tsr$end), strand=tsr$strand, score=tsr$nTAGs)
	tsr.filt <- tsr[tsr$nTAGs>=minTAGs,]
	tsrGR.filt <- tsrGR[tsrGR$score>=minTAGs,]
	ks.results <- c(rep(NA,nrow(tsr.filt)))
	sig.results <- c(rep(NA,nrow(tsr.filt)))
	my.var <- c(rep(NA,nrow(tsr.filt)))
	my.skew <- c(rep(NA,nrow(tsr.filt)))
	my.kurtosis <- c(rep(NA,nrow(tsr.filt)))
	tsr.out <- cbind(tsr.filt, my.var, my.skew, my.kurtosis, ks.results, sig.results)
	my.seq <- seq(1,nrow(tsr.filt))
	print(length(my.seq))
	print(head(my.seq))
	my.names <- paste("tsr", my.seq, sep="_")
	tags.list <- vector("list", length(my.names))
	rownames(tsr.out) <- my.names
	for (i in 1:nrow(as.data.frame(tsrGR.filt))) {
		this.selection <- subsetByOverlaps(tssGR, tsrGR.filt[i,])
		this.df <- as.data.frame(this.selection)
		tss.dist.sample <- tssVec(this.df)
		tags.list[[i]] <- tss.dist.sample
		r.dist <- round(rnorm(length(tss.dist.sample), mean=median(tss.dist.sample)))
		ks.out <- ks.test(tss.dist.sample, r.dist)
		ks.pval <- ks.out$p.value
		ks.stat <- ks.out$statistic
		tsr.out[i, 12] <- var(tss.dist.sample)
		tsr.out[i, 13] <- skewness(tss.dist.sample)
		tsr.out[i, 14] <- kurtosis(tss.dist.sample)
		if (ks.pval < ks.stat) {
		   c("significant") -> sig.result
		   }
		else { c("not_significant") -> sig.result }
		tsr.out[i, 15] <- as.numeric(ks.pval)
		tsr.out[i, 16] <- sig.result
		}
	if (write.file==TRUE) {
	   write.table(tsr.out, file="tssDist_out.txt", sep="\t", quote=FALSE, row.names=TRUE, col.names=TRUE)
		}
	save(tags.list, file="tssTagsList.RData")
}	
		
		