#!/bin/bash
#
#SBATCH -p hpc-bio-pacioli
#SBATCH --chdir=/home/alumno08
#SBATCH -J jai
#SBATCH --cpus-per-task=4
#SBATCH --ntasks=1
#SBATCH --mail-type=NONE    #END/START/NONE
#SBATCH --mail-user=soledad.arias@um.es


echo
echo "Ejecucion secuencial de programa poblaciones"

time while IFS="," read -r ciudad pais habitantes area
do
for i in $pais; do
       ./poblaciones ejercicio-ciudades.csv $i
done
done < <(tail -n +2 ejercicio-ciudades.csv)
wait


echo
echo "Ejecucion paralela de programa poblaciones"
while IFS="," read -r ciudad pais habitantes area
do
for i in $pais; do
       ./poblaciones ejercicio-ciudades.csv $i&
done
done < <(tail -n +2 ejercicio-ciudades.csv)
time wait

