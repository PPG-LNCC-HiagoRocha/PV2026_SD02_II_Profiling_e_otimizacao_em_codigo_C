#!/bin/bash
#
# Script SLURM para análise de memória com Valgrind
# Exemplo didático para curso
#

#SBATCH --job-name=matmul_valgrind
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=sequana_cpu_dev
#SBATCH --mem=0
#SBATCH --output=matmul_valgrind_%j.out

# -------------------------------------------------
# Ambiente
# -------------------------------------------------

module load gcc/14.2.0_sequana

# -------------------------------------------------
# Informações do job
# -------------------------------------------------

echo "======================================"
echo "Job SLURM iniciado (Valgrind)"
echo "Nome do job     : $SLURM_JOB_NAME"
echo "Job ID          : $SLURM_JOB_ID"
echo "Nó(s) alocado(s): $SLURM_NODELIST"
echo "Host            : $(hostname)"
echo "Data início     : $(date)"
echo "======================================"

# -------------------------------------------------
# Limpeza (opcional)
# -------------------------------------------------

echo "Limpando binário antigo"
rm -f matmul

# -------------------------------------------------
# Compilação (debug-friendly para Valgrind)
# -------------------------------------------------

echo "Compilando matmul.c para uso com Valgrind"
gcc -O0 -g matmul.c -o matmul

if [ $? -ne 0 ]; then
    echo "Erro na compilação. Abortando job."
    exit 1
fi

# -------------------------------------------------
# Execução com Valgrind
# -------------------------------------------------

# Use N pequeno: Valgrind é MUITO lento
N=64

echo "Executando com Valgrind: ./matmul $N"
valgrind \
  --leak-check=full \
  --show-leak-kinds=all \
  --track-origins=yes \
  ./matmul $N

if [ $? -ne 0 ]; then
    echo "Erro durante execução com Valgrind."
    exit 1
fi

# -------------------------------------------------
# Finalização
# -------------------------------------------------

echo "======================================"
echo "Execução com Valgrind finalizada"
echo "Verifique o relatório acima no output"
echo "======================================"
echo "Job finalizado"
echo "Data fim        : $(date)"
echo "======================================"
