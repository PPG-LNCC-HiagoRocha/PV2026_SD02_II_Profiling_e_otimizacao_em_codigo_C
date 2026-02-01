/*
Multiplicação de Matrizes Quadradas (N x N)
Avaliação do impacto da ordem dos loops no desempenho

INSTRUÇÕES DE COMPILAÇÃO
-----------------------
Exemplo (ordem i-k-j):
$ gcc -O3 -march=native -DLOOP_ORDER=1 matmul.c -o matmul

INSTRUÇÕES DE EXECUÇÃO
---------------------
$ ./matmul

OBSERVAÇÕES
-----------
- Complexidade O(N³)
- A primeira execução é descartada (warm-up)
- A medição usa clock_gettime()
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#ifndef LOOP_ORDER
#define LOOP_ORDER 0   /* padrão: i-j-k */
#endif

#define N 4096
#define NUM_EXECUCOES 2

/* Matrizes globais (segmento de dados) */
static float A[N][N];
static float B[N][N];
static float C[N][N];

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

        /* ===============================
           Kernel de multiplicação
           =============================== */

#if LOOP_ORDER == 0
        /* i-j-k */
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                for (int k = 0; k < N; k++)
                    C[i][j] += A[i][k] * B[k][j];

#elif LOOP_ORDER == 1
        /* i-k-j */
        for (int i = 0; i < N; i++)
            for (int k = 0; k < N; k++)
                for (int j = 0; j < N; j++)
                    C[i][j] += A[i][k] * B[k][j];

#elif LOOP_ORDER == 2
        /* j-i-k */
        for (int j = 0; j < N; j++)
            for (int i = 0; i < N; i++)
                for (int k = 0; k < N; k++)
                    C[i][j] += A[i][k] * B[k][j];

#elif LOOP_ORDER == 3
        /* j-k-i */
        for (int j = 0; j < N; j++)
            for (int k = 0; k < N; k++)
                for (int i = 0; i < N; i++)
                    C[i][j] += A[i][k] * B[k][j];

#elif LOOP_ORDER == 4
        /* k-i-j */
        for (int k = 0; k < N; k++)
            for (int i = 0; i < N; i++)
                for (int j = 0; j < N; j++)
                    C[i][j] += A[i][k] * B[k][j];

#elif LOOP_ORDER == 5
        /* k-j-i */
        for (int k = 0; k < N; k++)
            for (int j = 0; j < N; j++)
                for (int i = 0; i < N; i++)
                    C[i][j] += A[i][k] * B[k][j];
#endif

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
