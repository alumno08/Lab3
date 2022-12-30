#!/bin/bash
#
#SBATCH -p hpc-bio-pacioli
#SBATCH --chdir=/home/alumno08
#SBATCH -J jai
#SBATCH --cpus-per-task=4
#SBATCH --ntasks=1
#SBATCH --mail-type=NONE    #END/START/NONE
#SBATCH --mail-user=soledad.arias@um.es

echo "APARTADO 1"
echo
echo "Tiempo total de ejecucion de helloflops3-AVX con hilos diferentes"
echo
time for i in 1 2 4
do
	export OMP_NUM_THREADS=$i
	./helloflops3-AVX
done
wait
echo
echo "APARTADO 2"
echo
echo "Tiempo ejecucion  helloflops3-AVX con 4 CPU"
echo
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
time ./helloflops3-AVX
echo

module load fastqc/0.11.8
module load jdk/1.8.0
echo "APARTADO 3"
echo
echo "Tiempo de ejecucion Fastqc secuencial VS  paralela de Fastqc"
echo
echo "Fastqc secuencial"
echo
time for sample in "Sample*.fastq" 
do 
	fastqc $sample
done
wait
echo
echo "Fastqc paralela"
echo
time fastqc -t 4 Sample*.fastq
echo

echo "APARTADO 4"
echo
env |grep SLURM
echo
module unload fastqc/0.11.8
