#!/bin/bash
#
# Script SLURM para análise de desempenho com gprof
# Exemplo didático para curso
#

#SBATCH --job-name=matmul_gprof
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=sequana_cpu_dev
#SBATCH --mem=0
#SBATCH --output=matmul_gprof_%j.out

# -------------------------------------------------
# Ambiente
# -------------------------------------------------

module load gcc/14.2.0_sequana

# -------------------------------------------------
# Informações do job
# -------------------------------------------------

echo "======================================"
echo "Job SLURM iniciado (gprof)"
echo "Nome do job     : $SLURM_JOB_NAME"
echo "Job ID          : $SLURM_JOB_ID"
echo "Nó(s) alocado(s): $SLURM_NODELIST"
echo "Host            : $(hostname)"
echo "Data início     : $(date)"
echo "======================================"

# -------------------------------------------------
# Limpeza de arquivos antigos do gprof
# -------------------------------------------------

echo "Limpando arquivos antigos do gprof"
rm -f gmon.out gprof.txt

# -------------------------------------------------
# Compilação instrumentada para gprof
# -------------------------------------------------

echo "Compilando matmul.c com suporte a gprof"
gcc -O0 -g -pg matmul.c -o matmul

if [ $? -ne 0 ]; then
    echo "Erro na compilação. Abortando job."
    exit 1
fi

# -------------------------------------------------
# Execução
# -------------------------------------------------

# Use entrada razoável (nem muito pequena, nem benchmark)
N=512

echo "Executando: ./matmul $N"
./matmul $N

if [ $? -ne 0 ]; then
    echo "Erro na execução. Abortando job."
    exit 1
fi

# -------------------------------------------------
# Análise de perfil com gprof
# -------------------------------------------------

echo "Gerando relatório gprof"
gprof matmul gmon.out > gprof.txt

# -------------------------------------------------
# Finalização
# -------------------------------------------------

echo "======================================"
echo "Arquivos gerados:"
ls -lh gmon.out gprof.txt 2>/dev/null
echo "======================================"
echo "Job finalizado"
echo "Data fim        : $(date)"
echo "======================================"
