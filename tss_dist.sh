#!/usr/bin/sh

#PBS -N hs_tss_dist
#PBS -k o
#PBS -l nodes=1:ppn=16,vmem=32gb
#PBS -l walltime=12:00:00

myDir=/N/dc2/scratch/rtraborn/tss_distributions

cd $myDir

echo "Launching job"

R CMD BATCH tssDist_hs.R

echo "Job complete"
