#!/bin/bash

#SBATCH --job-name=compiler_opts
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=sequana_cpu_dev
#SBATCH --mem=2G
#SBATCH --output=compiler_opts_%j.out

# ======================================
# Configuração
# ======================================

TILES=(4 8 16 32 64 128)

SRC=../../matmul.c
CC=gcc

CFLAGS="-O3 -fopenmp"

# ======================================
# Diretórios
# ======================================

mkdir -p bin
mkdir -p reports
mkdir -p assembly
mkdir -p optimized

SUMMARY=compiler_optimization_report.txt

echo "==============================================" > $SUMMARY
echo " Compiler Optimization Report" >> $SUMMARY
echo "==============================================" >> $SUMMARY
echo "" >> $SUMMARY

printf "%-6s %-10s %-10s %-10s %-10s %-10s\n" \
"Tile" "ASM" "AVX" "Branch" "Calls" "Vectorized" >> $SUMMARY

# ======================================
# Compilação
# ======================================

for TILE in "${TILES[@]}"; do

    echo "Compilando TILE=${TILE}"

    BIN=bin/matmul_tile_${TILE}
    ASM=assembly/matmul_tile_${TILE}.s
    REP=reports/report_tile_${TILE}.txt
    OPT=optimized/tile_${TILE}.opt

    ####################################
    # Assembly
    ####################################

    $CC $CFLAGS \
        -DTILE=$TILE \
        -S \
        -fopt-info-all=$REP \
        -fdump-tree-optimized=$OPT \
        "$SRC" \
        -o "$ASM"

    ####################################
    # Executável
    ####################################

    $CC $CFLAGS \
        -DTILE=$TILE \
        "$SRC" \
        -o "$BIN"

    ####################################
    # Métricas do Assembly
    ####################################

    ASM_LINES=$(grep -v '^\.' "$ASM" | grep -v '^$' | wc -l)

    AVX=$(grep -E "vmov|vadd|vmul|vsub|vfmadd|vxor|ymm|xmm" "$ASM" | wc -l)

    BRANCH=$(grep -E '\sj[a-z]+' "$ASM" | wc -l)

    CALLS=$(grep -E '\scall' "$ASM" | wc -l)

    ####################################
    # Vetorização
    ####################################

    if grep -qi "vector" "$REP"; then
        VEC="YES"
    else
        VEC="NO"
    fi

    printf "%-6s %-10s %-10s %-10s %-10s %-10s\n" \
        "$TILE" "$ASM_LINES" "$AVX" "$BRANCH" "$CALLS" "$VEC" >> $SUMMARY

done

#############################################################
# Comparação dos assemblies
#############################################################

echo "" >> $SUMMARY
echo "==============================================" >> $SUMMARY
echo "Assembly Differences" >> $SUMMARY
echo "==============================================" >> $SUMMARY

for ((i=0;i<${#TILES[@]}-1;i++)); do

    A=${TILES[$i]}

    for ((j=i+1;j<${#TILES[@]};j++)); do

        B=${TILES[$j]}

        DIFF=$(diff assembly/matmul_tile_${A}.s \
                    assembly/matmul_tile_${B}.s | wc -l)

        printf "Tile %-3s x Tile %-3s : %5d linhas diferentes\n" \
            "$A" "$B" "$DIFF" >> $SUMMARY

    done

done

#############################################################
# Trechos do relatório do GCC
#############################################################

echo "" >> $SUMMARY
echo "==============================================" >> $SUMMARY
echo "Relevant GCC Optimizations" >> $SUMMARY
echo "==============================================" >> $SUMMARY

for TILE in "${TILES[@]}"; do

    echo "" >> $SUMMARY
    echo "---------- TILE ${TILE} ----------" >> $SUMMARY

    grep -Ei "vector|unroll|loop|peel|unswitch|inline|constant|propagation" \
        reports/report_tile_${TILE}.txt >> $SUMMARY

done

echo ""
echo "============================================="
echo "Relatório gerado:"
echo "   $SUMMARY"
echo "============================================="
