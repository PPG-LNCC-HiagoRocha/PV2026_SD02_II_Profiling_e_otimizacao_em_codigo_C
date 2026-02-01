#!/bin/bash

#SBATCH --job-name=matmul_c
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --time=00:20:00
#SBATCH --partition=sequana_cpu_dev
#SBATCH --mem=0
#SBATCH --output=matmul_c_%j.out

# ==============================
# Parâmetros do experimento
# ==============================
TILES=(4 8 16 32 64 128)
SRC=matmul.c
CC=gcc
CFLAGS="-O3 -fopenmp"

RESULTS=results_tiles.csv

echo "Tile,Tempo(s)" > $RESULTS

# ==============================
# Compilação e execução
# ==============================
for TILE in "${TILES[@]}"; do
    BIN=matmul_tile_${TILE}

    echo "===================================="
    echo "Compilando com TILE=${TILE}"
    echo "===================================="

    $CC $CFLAGS -DTILE=$TILE $SRC -o $BIN

    echo "Executando TILE=${TILE}..."

    # Executa e extrai apenas o tempo da execução válida (Execução 2)
    TIME=$(
        ./$BIN | grep "Execução 2" | awk '{print $3}'
    )

    echo "${TILE},${TIME}" >> $RESULTS
done

echo "===================================="
echo "Experimento finalizado"
echo "Resultados em: ${RESULTS}"
echo "===================================="
