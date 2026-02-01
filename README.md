# PV2026 – SD02-II: Profiling e Otimização em Código C/C++

Repositório com os códigos, exemplos e exercícios utilizados no curso **SD02-II: Profiling e Otimização de Código em C/C++**, ministrado na **Escola do Supercomputador Santos Dumont (2026)**.

O objetivo do curso é analisar desempenho, identificar gargalos e aplicar técnicas clássicas de otimização em arquiteturas modernas, explorando paralelismo, hierarquia de memória e vetorização.

---

## Objetivos

- Analisar o desempenho de códigos em C/C++
- Identificar gargalos computacionais e de memória
- Utilizar ferramentas de profiling
- Aplicar otimizações incrementais
- Comparar versões baseline e otimizadas
- Avaliar o impacto de:
  - hierarquia de cache
  - SIMD
  - paralelismo com OpenMP

---

## Estrutura do Repositório

### Parte 1 - Evolução do Código e Otimizações

Contém os códigos da primeira parte do curso, organizados como versões sucessivas que ilustram a evolução do desempenho a partir de diferentes estratégias:

- **Versão 1**: Loops aninhados em Python
- **Versão 2**: Loops aninhados em Java
- **Versão 3**: Loops aninhados em C
- **Versão 4**: Reordenação dos loops
- **Versão 5**: Uso de flags de otimização do compilador
- **Versão 6**: Paralelização de loops
- **Versão 7**: Tiling (blocagem para cache)
- **Versão 8**: Vetorização automática do compilador
- **Versão 9**: Uso da biblioteca Intel MKL

O foco desta parte é compreender como pequenas mudanças estruturais impactam o desempenho.

---

### Parte 2 - Profiling e Análise de Desempenho

Contém códigos e exercícios guiados da segunda parte do curso, focados no uso de ferramentas de profiling:

- **1-gcov**: Análise de cobertura de código com `gcov`
- **2-gprof**: Análise de tempo de execução com `gprof`
- **3-valgrind**: Análise de memória e cache com `valgrind` / `cachegrind`
- **4-perf**: Análise de eventos de hardware com `perf`

**Observação:**  
O arquivo `INSTALL_PROFILING_TOOLS.txt` contém as instruções para instalação de todas as ferramentas necessárias para o curso.

---

## Licença

Este projeto está licenciado sob a **Licença MIT**.
