/*
Multiplicação de Matrizes Quadradas (N x N) — Precisão Simples (FP32)

INSTRUÇÕES DE COMPILAÇÃO E EXECUÇÃO
----------------------------------
1. Certifique-se de ter o Java JDK 11 ou superior:
   $ java -version
   $ javac -version

2. Salve este arquivo como:
   MatMul.java

3. Compile o código:
   $ javac MatMul.java

4. Execute o programa:
   $ java MatMul

OBSERVAÇÕES IMPORTANTES
----------------------
- O algoritmo possui complexidade O(N³).
- O código utiliza precisão simples (FP32), usando o tipo float.
- Para N = 1024, o tempo de execução pode ser de vários minutos,
  dependendo do processador.
- O código executa o kernel principal 4 vezes:
    * a primeira execução é descartada (warm-up)
    * a média é calculada sobre as 3 execuções restantes
- A medição de tempo é feita com System.nanoTime().
*/

import java.util.Random;

public class MatMul {

    // Tamanho da matriz (N x N)
    static final int N = 4096;

    // Número total de execuções
    static final int NUM_EXECUCOES = 2;

    public static void main(String[] args) {

        Random rand = new Random();

        // Matrizes em precisão simples (FP32)
        float[][] A = new float[N][N];
        float[][] B = new float[N][N];

        // Inicialização das matrizes
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                A[i][j] = rand.nextFloat();
                B[i][j] = rand.nextFloat();
            }
        }

        float[] tempos = new float[NUM_EXECUCOES - 1];
        int idxTempo = 0;

        for (int execucao = 0; execucao < NUM_EXECUCOES; execucao++) {

            // Matriz resultado
            float[][] C = new float[N][N];

            long inicio = System.nanoTime();

            for (int i = 0; i < N; i++) {
                for (int j = 0; j < N; j++) {
                    for (int k = 0; k < N; k++) {
                        C[i][j] += A[i][k] * B[k][j];
                    }
                }
            }

            long fim = System.nanoTime();
            float tempoSegundos = (fim - inicio) / 1_000_000_000.0f;

            if (execucao == 0) {
                System.out.printf(
                    "Execução %d: %.6f s (descartada – warm-up)%n",
                    execucao + 1, tempoSegundos
                );
            } else {
                tempos[idxTempo++] = tempoSegundos;
                System.out.printf(
                    "Execução %d: %.6f s%n",
                    execucao + 1, tempoSegundos
                );
            }
        }

        // Cálculo da média
        float soma = 0.0f;
        for (float t : tempos) {
            soma += t;
        }

        float media = soma / tempos.length;

        System.out.printf("%nTempo médio: %.6f s%n", media);
    }
}
