source("tssDist.R")

tssDist("../humanCAGE/tsr/TSSsetCombined.bed", "../humanCAGE/tsr/TSRsetCombined.txt", minTAGs=30, write.file=TRUE)

q()