tssMode <- function(tssFile, tsrFile,  minTAGs=10, write.file=FALSE) { 
	source("tssVec.R")
	library(GenomicRanges)

	getMode <- function(v) {
		uniqv <- unique(v)
		uniqv[which.max(tabulate(match(v, uniqv)))]
		}
	
	tss <- read.table(file=tssFile, header=FALSE)
	colnames(tss) <- c("seq", "start", "end", "ID", "nTAGs", "strand")
	tssGR <- GRanges(seqnames=tss$seq, IRanges(tss$start, tss$end), strand=tss$strand, score=tss$nTAGs)
	tsr <- read.table(file=tsrFile, header=TRUE)
	tsrGR <- GRanges(seqnames=tsr$seq, IRanges(tsr$start, tsr$end), strand=tsr$strand, score=tsr$nTAGs)
	tsr.filt <- tsr[tsr$nTAGs>=minTAGs,]
	tsrGR.filt <- tsrGR[tsrGR$score>=minTAGs,]
	for (i in 1:nrow(as.data.frame(tsrGR.filt))) {
		this.selection <- subsetByOverlaps(tssGR, tsrGR.filt[i,])
		this.df <- as.data.frame(this.selection)
		tss.dist.sample <- tssVec(this.df)
		tss.mode <- getMode(tss.dist.sample)
		if (length(tss.mode) > 1) {
		   tss.mode <- sample(tss.mode, 1)
		}
	tsr.filt$modalTSS[i] <- tss.mode
	}
	if (write.file==TRUE) {
	   write.table(tsr.filt, file="tssMode_out.txt", sep="\t", quote=FALSE)
		}
	return(tsr.out)
}	
		
		