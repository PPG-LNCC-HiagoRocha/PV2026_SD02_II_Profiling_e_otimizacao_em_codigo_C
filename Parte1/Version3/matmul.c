/*
Multiplicação de Matrizes Quadradas (N x N)

INSTRUÇÕES DE COMPILAÇÃO E EXECUÇÃO
----------------------------------
1. Compile com GCC:
   $ gcc matmul.c -o matmul

2. Execute:
   $ ./matmul

OBSERVAÇÕES IMPORTANTES
----------------------
- O algoritmo possui complexidade O(N³).
- Para N = 1024, o tempo de execução pode ser de vários minutos.
- O código executa o kernel principal 4 vezes:
    * a primeira execução é descartada (warm-up)
    * a média é calculada sobre as 3 execuções restantes
- A medição de tempo é feita com clock_gettime().
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 4096
#define NUM_EXECUCOES 2

/* Matrizes globais (segmento de dados) */
float A[N][N];
float B[N][N];
float C[N][N];

double tempo_em_segundos(struct timespec inicio, struct timespec fim) {
    return (fim.tv_sec - inicio.tv_sec) +
           (fim.tv_nsec - inicio.tv_nsec) * 1e-9;
}

int main() {

    srand(0);

    /* Inicialização das matrizes A e B */
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            A[i][j] = (float) rand() / RAND_MAX;
            B[i][j] = (float) rand() / RAND_MAX;
        }
    }

    for (int execucao = 0; execucao < NUM_EXECUCOES; execucao++) {

        /* Zera a matriz resultado */
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                C[i][j] = 0.0f;

        struct timespec inicio, fim;
        clock_gettime(CLOCK_MONOTONIC, &inicio);

        /* Kernel de multiplicação de matrizes */
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                for (int k = 0; k < N; k++) {
                    C[i][j] += A[i][k] * B[k][j];
                }
            }
        }

        clock_gettime(CLOCK_MONOTONIC, &fim);

        double tempo = tempo_em_segundos(inicio, fim);

        if (execucao == 0) {
            printf("Execução %d: %.6f s (descartada – warm-up)\n",
                   execucao + 1, tempo);
        } else {
            printf("Execução %d: %.6f s\n",
                   execucao + 1, tempo);
        }
    }

    return 0;
}
