#!/bin/bash
#SBATCH --job-name=matmul_c
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --time=00:20:00
#SBATCH --partition=sequana_cpu_dev
#SBATCH --mem=0
#SBATCH --output=matmul_c_%j.out

module purge
module load gcc/14.2.0_sequana

RESULTS=results_versions.csv
echo "versao,tempo_s" > $RESULTS

run () {
    SRC=$1
    NAME=$2
    FLAGS=$3

    gcc $FLAGS $SRC -o matmul || exit 1

    TIME=$(./matmul | grep "Execução 2:" | awk -F: '{print $2}' | awk '{print $1}')
    echo "$NAME,$TIME" >> $RESULTS
}

run matmul.c      "v1"      "-O3 -fopenmp -march=native"
run matmul.c      "v2"      "-O3 -fopenmp -march=native -ffast-math"
run matmul_restrict.c  "v3" "-O3 -march=native -ffast-math -fopenmp"
run matmul_simd.c      "v4"    "-O3 -march=native -ffast-math -fopenmp"

echo "Resultados em $RESULTS"