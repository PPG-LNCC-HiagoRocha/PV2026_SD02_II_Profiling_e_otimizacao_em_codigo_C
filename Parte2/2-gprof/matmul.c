/*
Multiplicação de Matrizes Quadradas (N x N)
Versão preparada para análise com gprof

COMPILAÇÃO (gprof):
------------------
gcc -O0 -g -pg matmul.c -o matmul

EXECUÇÃO:
---------
./matmul 256

ANÁLISE:
--------
gprof matmul gmon.out > gprof.txt
vi gprof.txt
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NUM_EXECUCOES 2

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
 * (função crítica para o gprof)
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
        return 1;
    }

    int N = atoi(argv[1]);

    /* Alocação dinâmica */
    float **A = malloc(N * sizeof(float *));
    float **B = malloc(N * sizeof(float *));
    float **C = malloc(N * sizeof(float *));

    for (int i = 0; i < N; i++) {
        A[i] = malloc(N * sizeof(float));
        B[i] = malloc(N * sizeof(float));
        C[i] = malloc(N * sizeof(float));
    }

    srand(0);

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
