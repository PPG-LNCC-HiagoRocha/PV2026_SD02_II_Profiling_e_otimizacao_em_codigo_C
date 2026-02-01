"""
Multiplicação de Matrizes Quadradas (N x N)

INSTRUÇÕES DE EXECUÇÃO
---------------------
1. Certifique-se de ter Python 3.10 ou superior:
   $ python3 --version

2. Salve este arquivo como, por exemplo:
   matmul.py

3. Execute no terminal:
   $ python3 matmul.py

OBSERVAÇÕES IMPORTANTES
----------------------
- O algoritmo possui complexidade O(N³).
- Para N = 2028, o tempo de execução pode ser de vários minutos.
- O código executa o kernel principal 6 vezes:
    * a primeira execução é descartada (warm-up)
    * a média é calculada sobre as 5 execuções restantes
"""

import random
import time

# Tamanho da matriz (N x N)
n = 2028

# Inicialização das matrizes A e B
A = [[random.random() for _ in range(n)] for _ in range(n)]
B = [[random.random() for _ in range(n)] for _ in range(n)]

# Número total de execuções
num_execucoes = 2
tempos = []

for execucao in range(num_execucoes):
    # Reinicializa a matriz resultado a cada execução
    C = [[0.0 for _ in range(n)] for _ in range(n)]

    # Início da medição de tempo (alta resolução)
    inicio = time.perf_counter()

    # Loop principal da multiplicação de matrizes

    for i in range(n):
        for j in range(n):
            for k in range(n):
                C[i][j] += A[i][k] * B[k][j]

    # Fim da medição de tempo
    fim = time.perf_counter()
    tempo = fim - inicio

    if execucao == 0:
        # Primeira execução descartada (warm-up)
        print(f"Execução {execucao + 1}: {tempo:.6f} s (descartada – warm-up)")
    else:
        tempos.append(tempo)
        print(f"Execução {execucao + 1}: {tempo:.6f} s")

# Cálculo da média das execuções válidas
media = sum(tempos) / len(tempos)

print(f"\nTempo médio: {media:.6f} s")
