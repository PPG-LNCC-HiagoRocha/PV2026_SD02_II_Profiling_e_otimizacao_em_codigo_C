/*
Multiplicação de Matrizes Quadradas (N x N) usando Intel MKL (BLAS)

INSTRUÇÕES DE COMPILAÇÃO
-----------------------
Exemplo (Intel oneAPI):
  icx -O3 -qmkl matmul_mkl.c -o matmul_mkl

Ou com GCC + MKL:
  gcc -O3 -fopenmp matmul_mkl.c -o matmul_mkl \
      -I${MKLROOT}/include \
      -L${MKLROOT}/lib/intel64 \
      -lmkl_intel_lp64 -lmkl_core -lmkl_gnu_thread -lpthread -lm -ldl
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>
#include <mkl.h>   // MKL BLAS

#define N 16384
#define NUM_EXECUCOES 2

float *A;
float *B;
float *C;

double tempo_em_segundos(struct timespec inicio, struct timespec fim) {
    return (fim.tv_sec - inicio.tv_sec) +
           (fim.tv_nsec - inicio.tv_nsec) * 1e-9;
}

int main() {

    srand(0);

    size_t size = (size_t)N * N * sizeof(float);

    // MKL recomenda memória alinhada
    A = (float *) mkl_malloc(size, 64);
    B = (float *) mkl_malloc(size, 64);
    C = (float *) mkl_malloc(size, 64);

    if (!A || !B || !C) {
        fprintf(stderr, "Erro ao alocar memória\n");
        return 1;
    }

    // Inicialização
    for (int i = 0; i < N * N; i++) {
        A[i] = (float) rand() / RAND_MAX;
        B[i] = (float) rand() / RAND_MAX;
        C[i] = 0.0f;
    }

    // Controle explícito de threads da MKL
    mkl_set_dynamic(0);            // desabilita ajuste automático
    mkl_set_num_threads(omp_get_max_threads());

    for (int execucao = 0; execucao < NUM_EXECUCOES; execucao++) {

        // Zera C
        #pragma omp parallel for
        for (int i = 0; i < N * N; i++)
            C[i] = 0.0f;

        struct timespec inicio, fim;
        clock_gettime(CLOCK_MONOTONIC, &inicio);

        /*
         * C = A * B
         * Matrizes em row-major
         */
        cblas_sgemm(
            CblasRowMajor,      // layout
            CblasNoTrans,       // A não transposta
            CblasNoTrans,       // B não transposta
            N,                  // M
            N,                  // N
            N,                  // K
            1.0f,               // alpha
            A, N,               // A, lda
            B, N,               // B, ldb
            0.0f,               // beta
            C, N                // C, ldc
        );

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

    mkl_free(A);
    mkl_free(B);
    mkl_free(C);

    return 0;
}
