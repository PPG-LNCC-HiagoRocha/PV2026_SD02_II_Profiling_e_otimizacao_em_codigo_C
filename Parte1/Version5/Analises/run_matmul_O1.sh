#!/bin/bash
#
# Script SLURM para execução de multiplicação de matrizes (C)
# Exemplo didático para uso em curso
#

#SBATCH --job-name=matmul_c
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=sequana_cpu_dev
#SBATCH --mem=0
#SBATCH --output=matmul_c_%j.out

# -------------------------------------------------
# Ambiente
# -------------------------------------------------

module load gcc/14.2.0_sequana

# -------------------------------------------------
# Informações do job
# -------------------------------------------------

echo "======================================"
echo "Job SLURM iniciado"
echo "Nome do job     : $SLURM_JOB_NAME"
echo "Job ID          : $SLURM_JOB_ID"
echo "Nó(s) alocado(s): $SLURM_NODELIST"
echo "Host            : $(hostname)"
echo "Data início     : $(date)"
echo "======================================"

# -------------------------------------------------
# Compilação
# -------------------------------------------------

echo "Compilando matmul.c"
gcc -O1 matmul.c -o matmul

if [ $? -ne 0 ]; then
    echo "Erro na compilação. Abortando job."
    exit 1
fi

# -------------------------------------------------
# Execução
# -------------------------------------------------

echo "Executando: ./matmul"
./matmul

# -------------------------------------------------
# Finalização
# -------------------------------------------------

echo "======================================"
echo "Job finalizado"
echo "Data fim        : $(date)"
echo "======================================"
