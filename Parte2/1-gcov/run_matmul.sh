#!/bin/bash
#
# Script SLURM para análise de cobertura com gcov
# Exemplo didático para curso
#

#SBATCH --job-name=matmul_gcov
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=sequana_cpu_dev
#SBATCH --mem=0
#SBATCH --output=matmul_gcov_%j.out

# -----------------------------------------------
# SLURM – Execução interativa (apenas para testes)
# -----------------------------------------------

# 1) Solicitar alocação interativa
#salloc -p sequana_cpu_dev -N 1 -n 1 -c 1 --time=00:20:00

# 2) (Opcional) Conectar manualmente ao nó alocado
#ssh $SLURM_JOB_NODELIST

# 3) Finalizar a sessão interativa (libera o nó)
#exit

# 4) (Emergência) Cancelar o job interativo
#scancel $SLURM_JOB_ID

# -------------------------------------------------
# Ambiente
# -------------------------------------------------

module load gcc/14.2.0_sequana

# -------------------------------------------------
# Informações do job
# -------------------------------------------------

echo "======================================"
echo "Job SLURM iniciado (gcov)"
echo "Nome do job     : $SLURM_JOB_NAME"
echo "Job ID          : $SLURM_JOB_ID"
echo "Nó(s) alocado(s): $SLURM_NODELIST"
echo "Host            : $(hostname)"
echo "Data início     : $(date)"
echo "======================================"

# -------------------------------------------------
# Limpeza de arquivos antigos gcov
# -------------------------------------------------

echo "Limpando arquivos gcov antigos"
rm -f *.gcda *.gcno *.gcov

# -------------------------------------------------
# Compilação instrumentada
# -------------------------------------------------

echo "Compilando matmul.c com suporte a gcov"
gcc -O0 -g -fprofile-arcs -ftest-coverage matmul.c -o matmul

if [ $? -ne 0 ]; then
    echo "Erro na compilação. Abortando job."
    exit 1
fi

# -------------------------------------------------
# Execução
# -------------------------------------------------

# Use N pequeno para análise de cobertura
N=128

echo "Executando: ./matmul $N"
./matmul $N

if [ $? -ne 0 ]; then
    echo "Erro na execução. Abortando job."
    exit 1
fi

# -------------------------------------------------
# Análise de cobertura
# -------------------------------------------------

echo "Gerando relatório gcov"
gcov matmul.c

# -------------------------------------------------
# Finalização
# -------------------------------------------------

echo "======================================"
echo "Arquivos gerados:"
ls -lh *.gcov *.gcda *.gcno 2>/dev/null
echo "======================================"
echo "Job finalizado"
echo "Data fim        : $(date)"
echo "======================================"
