#!/bin/bash
#
# Script SLURM para execução de multiplicação de matrizes (MatMul.java)
# Exemplo didático para uso em curso
#

#SBATCH --job-name=matmul_java           # Nome do job
#SBATCH --nodes=1                        # Número de nós alocados
#SBATCH --ntasks=1                       # Número de tarefas (processos MPI)
#SBATCH --cpus-per-task=1                # Número de CPUs (cores) por tarefa
#SBATCH --time=00:20:00                  # Tempo máximo de execução (HH:MM:SS)
#SBATCH --partition=sequana_cpu_dev      # Partição (fila) do cluster
#SBATCH --mem=0                          # Usa toda a memória disponível do nó
#SBATCH --output=matmul_java_%j.out      # Arquivo de saída (%j = JobID)

# -------------------------------------------------
# Ambiente de execução
# -------------------------------------------------

# Carrega o módulo Java (ajuste para o módulo disponível no cluster)
module load java/jdk-12_sequana

# -------------------------------------------------
# Informações do job (útil para debug e relatório)
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
# Compilação do código Java
# -------------------------------------------------

echo "Compilando: MatMul.java"
javac MatMul.java

# Verifica se a compilação foi bem-sucedida
if [ $? -ne 0 ]; then
    echo "Erro na compilação. Abortando job."
    exit 1
fi

# -------------------------------------------------
# Execução da aplicação
# -------------------------------------------------

echo "Executando: java MatMul"
#java -Xmx8g MatMul
java MatMul

# -------------------------------------------------
# Finalização
# -------------------------------------------------

echo "======================================"
echo "Job finalizado"
echo "Data fim        : $(date)"
echo "======================================"
