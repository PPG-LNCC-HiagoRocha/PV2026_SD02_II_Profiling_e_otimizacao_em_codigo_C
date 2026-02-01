/*
Multiplicação de Matrizes Quadradas (N x N)
Versão preparada para análise com Valgrind

COMPILAÇÃO (Valgrind):
---------------------
gcc -O0 -g matmul.c -o matmul

EXECUÇÃO COM VALGRIND:
---------------------
valgrind --tool=cachegrind --cache-sim=yes ./matmul 512

*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NUM_EXECUCOES 1

/* -------------------------------------------------
 * Função auxiliar de tempo
 * ------------------------------------------------- */
double tempo_em_segundos(struct timespec inicio, struct timespec fim) {
    return (fim.tv_sec - inicio.tv_sec) +
           (fim.tv_nsec - inicio.tv_nsec) * 1e-9;
}

/* -------------------------------------------------
 * Inicialização das matrizes
 * ------------------------------------------------- */
void inicializa_matrizes(float **A, float **B, int N) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            A[i][j] = (float) rand() / RAND_MAX;
            B[i][j] = (float) rand() / RAND_MAX;
        }
    }
}

/* -------------------------------------------------
 * Zera matriz resultado
 * ------------------------------------------------- */
void zera_matriz(float **C, int N) {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            C[i][j] = 0.0f;
}

/* -------------------------------------------------
 * Kernel principal de multiplicação
 * ------------------------------------------------- */
void matmul_kernel(float **A, float **B, float **C, int N) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            for (int k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

int main(int argc, char *argv[]) {

    if (argc != 2) {
        fprintf(stderr, "Uso: %s <N>\n", argv[0]);
        return EXIT_FAILURE;
    }

    int N = atoi(argv[1]);
    if (N <= 0) {
        fprintf(stderr, "Erro: N deve ser positivo.\n");
        return EXIT_FAILURE;
    }

    srand(0);

    /* -------------------------------------------------
     * Alocação dinâmica com verificação
     * ------------------------------------------------- */
    float **A = malloc(N * sizeof(float *));
    float **B = malloc(N * sizeof(float *));
    float **C = malloc(N * sizeof(float *));

    if (!A || !B || !C) {
        fprintf(stderr, "Erro: falha ao alocar ponteiros de matriz.\n");
        return EXIT_FAILURE;
    }

    for (int i = 0; i < N; i++) {
        A[i] = malloc(N * sizeof(float));
        B[i] = malloc(N * sizeof(float));
        C[i] = malloc(N * sizeof(float));

        if (!A[i] || !B[i] || !C[i]) {
            fprintf(stderr, "Erro: falha ao alocar linhas da matriz.\n");

            /* Liberação parcial segura */
            for (int j = 0; j <= i; j++) {
                free(A[j]);
                free(B[j]);
                free(C[j]);
            }
            free(A);
            free(B);
            free(C);
            return EXIT_FAILURE;
        }
    }

    /* Inicialização correta */
    inicializa_matrizes(A, B, N);

    for (int execucao = 0; execucao < NUM_EXECUCOES; execucao++) {

        zera_matriz(C, N);

        struct timespec inicio, fim;
        clock_gettime(CLOCK_MONOTONIC, &inicio);

        matmul_kernel(A, B, C, N);

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

    /* -------------------------------------------------
     * Liberação final (sem vazamentos)
     * ------------------------------------------------- */
    for (int i = 0; i < N; i++) {
        free(A[i]);
        free(B[i]);
        free(C[i]);
    }
    free(A);
    free(B);
    free(C);

    return EXIT_SUCCESS;
}
