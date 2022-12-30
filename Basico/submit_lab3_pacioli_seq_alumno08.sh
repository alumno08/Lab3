#!/bin/bash
#
#SBATCH -p hpc-bio-pacioli
#SBATCH --chdir=/home/alumno08
#SBATCH -J jai
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=4
#SBATCH --mail-type=END    #END/START/NONE
#SBATCH --mail-user=soledad.arias@um.es

echo "Secuencial" 
echo

time for (( i=1; i <= 4; i++ ))
do
echo
echo El programa se ha ejecutado $i veces
./helloflops1-AVX
done


echo  "Paralelo &"
echo
for (( i=1; i <= 4; i++ ))
do
echo
echo El programa se ha ejecutado $i veces
./helloflops1-AVX&
done
time wait

echo 
echo "Paralelo con srun"
echo

time srun -n 4 ./helloflops1-AVX

echo
echo "Paralelo con Parallel"

time  parallel ::: ./helloflops1-AVX
echo



