#!/usr/bin/sh

#PBS -N hs_tss_mode
#PBS -k o
#PBS -l nodes=1:ppn=16,vmem=32gb
#PBS -l walltime=1:00:00
#PBS -q debug

myDir=/N/dc2/scratch/rtraborn/tss_distributions

cd $myDir

echo "Launching job"

R CMD BATCH tssMode_hs.R

echo "Job complete"
