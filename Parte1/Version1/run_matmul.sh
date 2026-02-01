#!/bin/bash
#
# Script SLURM para execução de multiplicação de matrizes (matmul.py)
# Exemplo didático para uso em curso
#

#SBATCH --job-name=matmul            # Nome do job
#SBATCH --nodes=1                    # Número de nós alocados
#SBATCH --ntasks=1                   # Número de tarefas (processos MPI)
#SBATCH --cpus-per-task=1            # Número de CPUs (cores) por tarefa
#SBATCH --time=00:20:00              # Tempo máximo de execução (HH:MM:SS)
#SBATCH --partition=sequana_cpu_dev      # Partição (fila) do cluster
#SBATCH --mem=0                      # Usa toda a memória disponível do nó
#SBATCH --output=matmul_%j.out       # Arquivo de saída (%j = JobID)

# -------------------------------------------------
# Ambiente de execução
# -------------------------------------------------

# Carrega o módulo de Python, se necessário no cluster
module load python/3.13.1_sequana

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
# Execução da aplicação
# -------------------------------------------------

echo "Executando: python3 matmul.py"
python3 matmul.py

# -------------------------------------------------
# Finalização
# -------------------------------------------------

echo "======================================"
echo "Job finalizado"
echo "Data fim        : $(date)"
echo "======================================"