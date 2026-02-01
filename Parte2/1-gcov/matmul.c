/*
Multiplicação de Matrizes Quadradas (N x N)
Versão preparada para análise com gcov

COMPILAÇÃO (gcov):
------------------
gcc -O0 -fprofile-arcs -ftest-coverage matmul.c -o matmul

EXECUÇÃO:
---------
./matmul 256

ANÁLISE:
--------
gcov matmul.c
vi matmul.c.gcov
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NUM_EXECUCOES 1

double tempo_em_segundos(struct timespec inicio, struct timespec fim) {
    return (fim.tv_sec - inicio.tv_sec) +
           (fim.tv_nsec - inicio.tv_nsec) * 1e-9;
}

int main(int argc, char *argv[]) {

    if (argc != 2) {
        fprintf(stderr, "Uso: %s <N>\n", argv[0]);
        return 1;
    }

    int N = atoi(argv[1]);

    /* Alocação dinâmica para facilitar análise com N pequeno */
    float **A = malloc(N * sizeof(float *));
    float **B = malloc(N * sizeof(float *));
    float **C = malloc(N * sizeof(float *));

    for (int i = 0; i < N; i++) {
        A[i] = malloc(N * sizeof(float));
        B[i] = malloc(N * sizeof(float));
        C[i] = malloc(N * sizeof(float));
    }

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

        /* Kernel principal */
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
            printf("Execução %d: %.6f s (warm-up)\n",
                   execucao + 1, tempo);
        } else {
            printf("Execução %d: %.6f s\n",
                   execucao + 1, tempo);
        }
    }

    /* Liberação */
    for (int i = 0; i < N; i++) {
        free(A[i]);
        free(B[i]);
        free(C[i]);
    }
    free(A);
    free(B);
    free(C);

    return 0;
}
