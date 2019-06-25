source("tssDist.R")

tssDist("../humanCAGE/tsr/TSSsetCombined.bed", "../humanCAGE/tsr/TSRsetCombined.txt", minTAGs=50, write.file=TRUE)

q()