/*
Multiplicação de Matrizes Quadradas (N x N) com Tiling (Blocking)

INSTRUÇÕES DE COMPILAÇÃO E EXECUÇÃO
----------------------------------
1. Compile com GCC + OpenMP:
   $ gcc -O3 -fopenmp matmul.c -o matmul

2. Execute:
   $ ./matmul
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

#ifndef TILE
#define TILE 16
#endif

#define N 16384
#define NUM_EXECUCOES 2

/* Matrizes no heap */
float *restrict A;
float *restrict B;
float *restrict C;

double tempo_em_segundos(struct timespec inicio, struct timespec fim) {
    return (fim.tv_sec - inicio.tv_sec) +
           (fim.tv_nsec - inicio.tv_nsec) * 1e-9;
}

int main() {

    srand(0);

    /* Alocação dinâmica */
    size_t size = (size_t)N * N * sizeof(float);

    A = (float *) malloc(size);
    B = (float *) malloc(size);
    C = (float *) malloc(size);

    if (!A || !B || !C) {
        fprintf(stderr, "Erro ao alocar memória\n");
        return 1;
    }

    /* Inicialização das matrizes A e B */
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            A[i*N + j] = (float) rand() / RAND_MAX;
            B[i*N + j] = (float) rand() / RAND_MAX;
        }
    }

    for (int execucao = 0; execucao < NUM_EXECUCOES; execucao++) {

        /* Zera a matriz resultado */
        #pragma omp parallel for
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                C[i*N + j] = 0.0f;

        struct timespec inicio, fim;
        clock_gettime(CLOCK_MONOTONIC, &inicio);

        /* Kernel principal com TILING */
        #pragma omp parallel for schedule(static)
        for (int ii = 0; ii < N; ii += TILE) {
            for (int kk = 0; kk < N; kk += TILE) {
                for (int jj = 0; jj < N; jj += TILE) {

                    int i_max = (ii + TILE < N) ? ii + TILE : N;
                    int k_max = (kk + TILE < N) ? kk + TILE : N;
                    int j_max = (jj + TILE < N) ? jj + TILE : N;

                    for (int i = ii; i < i_max; i++) {
                        for (int k = kk; k < k_max; k++) {
                            float aik = A[i*N + k];

                            #pragma omp simd
                            for (int j = jj; j < j_max; j++) {
                                C[i*N + j] += aik * B[k*N + j];
                            }
                        }
                    }
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

    /* Liberação de memória */
    free(A);
    free(B);
    free(C);

    return 0;
}
