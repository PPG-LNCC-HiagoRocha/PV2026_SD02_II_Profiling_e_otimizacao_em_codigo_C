/*
Multiplicação de Matrizes Quadradas (N x N)

INSTRUÇÕES DE COMPILAÇÃO E EXECUÇÃO
----------------------------------
1. Compile com GCC + OpenMP:
   $ gcc -O3 -fopenmp matmul.c -o matmul

2. Execute:
   $ ./matmul

OBSERVAÇÕES IMPORTANTES
----------------------
- O algoritmo possui complexidade O(N³).
- O código executa o kernel principal NUM_EXECUCOES vezes:
    * a primeira execução é descartada (warm-up)
- A medição de tempo é feita com clock_gettime().
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>

#define N 16384
#define NUM_EXECUCOES 2

/* Matrizes no heap */
float *A;
float *B;
float *C;

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

        /* Kernel principal: ordem i–k–j mantida */
        #pragma omp parallel for
        for (int i = 0; i < N; i++) {
            for (int k = 0; k < N; k++) {
                float aik = A[i*N + k];
                for (int j = 0; j < N; j++) {
                    C[i*N + j] += aik * B[k*N + j];
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