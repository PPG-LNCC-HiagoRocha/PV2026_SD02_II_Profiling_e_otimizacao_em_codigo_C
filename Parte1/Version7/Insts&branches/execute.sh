#!/bin/bash

#SBATCH --job-name=perf_tiles
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=sequana_cpu_dev
#SBATCH --mem=2G
#SBATCH --output=perf_tiles_%j.out

######################################
# Configuração
######################################

#module load gcc/14.2.0_sequana

TILES=(4 8 16 32 64 128)

SRC=../matmul.c
CC=gcc

CFLAGS="-O3 -fopenmp"

######################################
# Diretórios
######################################

mkdir -p bin
mkdir -p perf

SUMMARY=perf_report.txt

echo "==========================================================" > $SUMMARY
echo "Perf Report" >> $SUMMARY
echo "==========================================================" >> $SUMMARY
echo "" >> $SUMMARY

printf "%-6s %-18s %-18s %-18s\n" \
"Tile" "Instructions" "Branches" "BranchMisses" \
>> $SUMMARY

######################################
# Experimentos
######################################

for TILE in "${TILES[@]}"; do

    echo "Executando TILE=${TILE}"

    BIN=bin/matmul_tile_${TILE}
    PERF=perf/perf_tile_${TILE}.txt

    ####################################
    # Compilação
    ####################################

    $CC $CFLAGS \
        -DTILE=$TILE \
        "$SRC" \
        -o "$BIN"

    ####################################
    # Perf
    ####################################

    perf stat \
        -x ';' \
        -r 10 \
        -e instructions,branches,branch-misses \
        "$BIN" \
        2> "$PERF"

    ####################################
    # Extração das métricas
    ####################################

    INS=$(awk -F';' '$3=="instructions"{print $1}' "$PERF")
    BRA=$(awk -F';' '$3=="branches"{print $1}' "$PERF")
    BRM=$(awk -F';' '$3=="branch-misses"{print $1}' "$PERF")

    ####################################
    # Resumo
    ####################################

    printf "%-6s %-18s %-18s %-18s\n" \
        "$TILE" \
        "$INS" \
        "$BRA" \
        "$BRM" \
        >> $SUMMARY

done

echo ""
echo "============================================="
echo "Relatório gerado:"
echo "    $SUMMARY"
echo "============================================="
