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
# Ambiente
# ==============================

module purge

# Ajuste o módulo conforme o ambiente do cluster
# Exemplo comum:
module load intel-oneapi/2025.0_sequana
# ou, se usar GCC + MKL:
# module load gcc/14.2.0_sequana
# module load mkl

# ==============================
# Arquivos
# ==============================

SRC="matmul_mkl.c"
BIN="matmul_mkl"

# ==============================
# Compilação
# ==============================

echo "===================================="
echo "Compilando código com Intel MKL"
echo "===================================="

# Opção 1 — Intel oneAPI (recomendada)
icx -O3 -qmkl ${SRC} -o ${BIN}

# ---- OU ----
# Opção 2 — GCC + MKL (descomente se necessário)
# gcc -O3 -fopenmp ${SRC} -o ${BIN} \
#     -I${MKLROOT}/include \
#     -L${MKLROOT}/lib/intel64 \
#     -lmkl_intel_lp64 -lmkl_core -lmkl_gnu_thread \
#     -lpthread -lm -ldl

if [ $? -ne 0 ]; then
    echo "Erro na compilação"
    exit 1
fi

# ==============================
# Execução
# ==============================

echo "===================================="
echo "Executando ${BIN}"
echo "OMP_NUM_THREADS=${OMP_NUM_THREADS}"
echo "MKL_NUM_THREADS=${MKL_NUM_THREADS}"
echo "===================================="

./${BIN}

echo "===================================="
echo "Execução finalizada"
echo "===================================="
