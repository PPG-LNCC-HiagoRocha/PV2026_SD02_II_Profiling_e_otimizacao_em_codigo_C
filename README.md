# PV2026 – SD02-II: Profiling e Otimização em Código C/C++

Este repositório reúne os slides, códigos, exemplos e exercícios utilizados no curso **SD02-II: Profiling e Otimização de Código em C/C++**, ministrado durante a **Escola do Supercomputador Santos Dumont – 2026**.

O curso tem como foco a análise de desempenho, a identificação de gargalos e a aplicação de técnicas clássicas de otimização em arquiteturas modernas, explorando paralelismo, hierarquia de memória e vetorização.

---

## 👨‍🏫 Professor

**Hiago Mayk G. de A. Rocha**  
📧 E-mail: [mayk@lncc.br](mailto:mayk@lncc.br)

---

## 🎥 Vídeo da Aula

▶️ Aula disponível no YouTube:  
https://www.youtube.com/live/WfB66mGI4yQ?si=IEKMVxkw_0L9z4Bh

---

## 🎯 Objetivos do Curso

- Analisar o desempenho de códigos em C/C++
- Identificar gargalos computacionais e de memória
- Utilizar ferramentas de profiling
- Aplicar otimizações de forma incremental
- Comparar versões *baseline* e versões otimizadas
- Avaliar o impacto de:
  - hierarquia de cache
  - vetorização SIMD
  - paralelismo com OpenMP

---

## 📁 Estrutura do Repositório

Os slides utilizados durante o curso estão organizados em duas partes:

- **SD02-II – Parte 1: Profiling e Otimização em Código C/C++**  
  Slides referentes à primeira parte do curso, com foco na evolução do código e técnicas de otimização.

- **SD02-II – Parte 2: Profiling e Otimização em Código C/C++**  
  Slides da segunda parte do curso, dedicados ao uso de ferramentas de profiling e análise de desempenho.

### Parte 1 — Evolução do Código e Otimizações

Esta parte contém os códigos da primeira etapa do curso, organizados como versões sucessivas que ilustram a evolução do desempenho a partir de diferentes estratégias de otimização:

- **Versão 1**: Loops aninhados em Python  
- **Versão 2**: Loops aninhados em Java  
- **Versão 3**: Loops aninhados em C  
- **Versão 4**: Reordenação dos loops  
- **Versão 5**: Uso de *flags* de otimização do compilador  
- **Versão 6**: Paralelização de loops  
- **Versão 7**: Tiling (blocagem para melhor uso de cache)  
- **Versão 8**: Vetorização automática pelo compilador  
- **Versão 9**: Uso da biblioteca Intel MKL  

O objetivo desta parte é demonstrar como pequenas mudanças estruturais podem gerar impactos significativos no desempenho.

---

### Parte 2 — Profiling e Análise de Desempenho

Esta parte reúne códigos e exercícios guiados focados no uso de ferramentas de profiling para análise detalhada de desempenho:

- **1-gcov**: Análise de cobertura de código com `gcov`
- **2-gprof**: Análise de tempo de execução com `gprof`
- **3-valgrind**: Análise de uso de memória e cache com `valgrind` / `cachegrind`
- **4-perf**: Análise de eventos de hardware com `perf`

**Observação:**  
O arquivo `INSTALL_PROFILING_TOOLS.txt` contém instruções para a instalação de todas as ferramentas necessárias para a realização dos exercícios.

---

## 📚 Referências

- MIT OpenCourseWare — *6.172 Performance Engineering of Software Systems*.  
  Disponível em: https://ocw.mit.edu/courses/6-172-performance-engineering-of-software-systems-fall-2018/  
  Acesso em: 2 fev. 2026.

- BORIN, Edson. *LNCC14 – Material da disciplina*. Universidade Estadual de Campinas (UNICAMP).  
  Disponível em: https://www.ic.unicamp.br/~edson/disciplinas/lncc14/  
  Acesso em: 2 fev. 2026.

- PROGRAMA DE VERÃO SD02-II. *Profiling e otimização em códigos C/C++*.  
  YouTube, 2025.  
  Disponível em: https://www.youtube.com/live/OTAUEx197CE  
  Acesso em: 2 fev. 2026.

---

## 📄 Licença

Este projeto está licenciado sob a **Licença MIT**.
