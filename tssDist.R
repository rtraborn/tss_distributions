tssDist <- function(tssFile, tsrFile,  minTAGs=10, write.file=FALSE) { 
	source("tssVec.R")
	library(GenomicRanges)
	tss <- read.table(file=tssFile, header=FALSE)
	colnames(tss) <- c("seq", "start", "end", "ID", "nTAGs", "strand")
	tssGR <- GRanges(seqnames=tss$seq, IRanges(tss$start, tss$end), strand=tss$strand, score=tss$nTAGs)
	tsr <- read.table(file=tsrFile, header=TRUE)
	tsrGR <- GRanges(seqnames=tsr$seq, IRanges(tsr$start, tsr$end), strand=tsr$strand, score=tsr$nTAGs)
	tsr.filt <- tsr[tsr$nTAGs>=minTAGs,]
	tsrGR.filt <- tsrGR[tsrGR$score>=minTAGs,]
	ks.results <- c(rep(NA,nrow(tsr.filt)))
	sig.results <- c(rep(NA,nrow(tsr.filt)))
	tsr.out <- cbind(tsr.filt, ks.results, sig.results)
	for (i in 1:nrow(as.data.frame(tsrGR.filt))) {
		this.selection <- subsetByOverlaps(tssGR, tsrGR.filt[i,])
		this.df <- as.data.frame(this.selection)
		tss.dist.sample <- tssVec(this.df)
		r.dist <- round(rnorm(length(tss.dist.sample), mean=median(tss.dist.sample)))
		ks.out <- ks.test(tss.dist.sample, r.dist)
		ks.pval <- ks.out$p.value
		ks.stat <- ks.out$statistic
		if (ks.pval < ks.stat) {
		   c("significant") -> sig.result
		   }
		else { c("not_significant") -> sig.result }
		tsr.out[i, 12] <- as.numeric(ks.pval)
		tsr.out[i, 13] <- sig.result
		}
	if (write.file==TRUE) {
	   write.table(tsr.out, file="tssDist_ks_out.txt", sep="\t", quote=FALSE)
	   }
	return(tsr.out)
}	
		
		