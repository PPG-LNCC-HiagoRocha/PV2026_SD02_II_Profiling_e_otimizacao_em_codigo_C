#!/bin/bash
#
# Executa UMA ordem de loops da multiplicação de matrizes
#

#SBATCH --job-name=matmul_one
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=sequana_cpu_dev
#SBATCH --mem=0
#SBATCH --output=matmul_%x_%j.out

# -----------------------------
# Verificação de argumento
# -----------------------------
if [ $# -lt 1 ]; then
    echo "Uso: sbatch run_one_order.sh <LOOP_ORDER>"
    echo "Exemplo: sbatch run_one_order.sh 1"
    exit 1
fi

LOOP_ORDER=$1

echo "======================================"
echo "Executando LOOP_ORDER = $LOOP_ORDER"
echo "Host : $(hostname)"
echo "Data : $(date)"
echo "======================================"

# Compilação
gcc -O3 -DLOOP_ORDER=${LOOP_ORDER} matmul_comb.c -o matmul_${LOOP_ORDER}

# Execução
./matmul_${LOOP_ORDER}

echo "======================================"
echo "Finalizado em: $(date)"
echo "======================================"
