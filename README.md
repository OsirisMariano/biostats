# 🧬 BioStats - Monitor Vital

O **BioStats** é uma aplicação de linha de comando (CLI) desenvolvida em **Ruby** para auxiliar no monitoramento de métricas vitais básicas. O projeto foi construído focando em boas práticas de programação, separação de responsabilidades e experiência do usuário no terminal.

## 🚀 Funcionalidades
- **Cálculo de IMC:** Índice de Massa Corporal com classificação automática.
- **Cálculo de TMB:** Taxa Metabólica Basal usando a fórmula de Mifflin-St Jeor.
- **Entrada Blindada:** Tratamento de erros (begin/rescue) para garantir que letras não quebrem os cálculos.
- **Interface Visual:** Relatórios coloridos via sequências ANSI para fácil interpretação.

## 🛠️ Tecnologias Utilizadas
- **Linguagem:** Ruby
- **Versionamento:** Git & GitHub
- **Arquitetura:** Modular (Módulos separados para Lógica e Input)

## 📖 Aprendizados (Método Feynman)
Durante o desenvolvimento deste projeto, foram consolidados conceitos como:
1. **Módulos:** Encapsulamento de métodos para evitar poluição do escopo global.
2. **Sanitização de Dados:** Uso de `.gsub`, `.strip` e `.upcase` para tratar strings.
3. **Controle de Fluxo:** Implementação de `loop do` e `case/when` para lógica de decisão.

---
