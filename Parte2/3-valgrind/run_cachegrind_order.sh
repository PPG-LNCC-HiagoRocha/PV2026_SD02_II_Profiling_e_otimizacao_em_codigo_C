#!/bin/bash
#
# Script SLURM para análise de cache com Cachegrind (Valgrind)
# Exemplo didático para curso
#

#SBATCH --job-name=matmul_cachegrind
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=sequana_cpu_dev
#SBATCH --mem=0
#SBATCH --output=matmul_cachegrind_%j.out

# -------------------------------------------------
# Ambiente
# -------------------------------------------------

module load gcc/14.2.0_sequana

# -------------------------------------------------
# Informações do job
# -------------------------------------------------

echo "======================================"
echo "Job SLURM iniciado (Cachegrind)"
echo "Nome do job     : $SLURM_JOB_NAME"
echo "Job ID          : $SLURM_JOB_ID"
echo "Nó(s) alocado(s): $SLURM_NODELIST"
echo "Host            : $(hostname)"
echo "Data início     : $(date)"
echo "======================================"

# -------------------------------------------------
# Limpeza
# -------------------------------------------------

echo "Limpando binário e arquivos antigos"
rm -f matmul_order cachegrind.out.*

# -------------------------------------------------
# Compilação (debug-friendly)
# -------------------------------------------------

echo "Compilando matmul_order.c para uso com Cachegrind"
gcc -O0 -g matmul_order.c -o matmul_order

if [ $? -ne 0 ]; then
    echo "Erro na compilação. Abortando job."
    exit 1
fi

# -------------------------------------------------
# Execução com Cachegrind
# -------------------------------------------------

# Use N pequeno/médio (cachegrind é lento)
N=512

echo "Executando com Cachegrind: ./matmul_order $N"
valgrind \
  --tool=cachegrind \
  --cachegrind-out-file=cachegrind.out.%p \
  ./matmul_order $N

if [ $? -ne 0 ]; then
    echo "Erro durante execução com Cachegrind."
    exit 1
fi

# -------------------------------------------------
# Finalização
# -------------------------------------------------

echo "======================================"
echo "Execução com Cachegrind finalizada"
echo "Arquivo gerado:"
ls -lh cachegrind.out.*
echo "======================================"
echo "Job finalizado"
echo "Data fim        : $(date)"
echo "======================================"
