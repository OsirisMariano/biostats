# 🧬 BioStats v2.0

O **BioStats** é uma ferramenta profissional de linha de comando (CLI) desenvolvida em Ruby para gestão de saúde e bem-estar. O sistema realiza cálculos antropométricos precisos, valida dados em tempo real e gerencia um histórico completo de clientes.



## 🚀 Funcionalidades

- **Cálculos Precisos**: IMC, Taxa Metabólica Basal (TMB - Harris-Benedict), Gasto Calórico Diário e Recomendação de Ingestão de Água.
- **Interface Interativa**: Navegação intuitiva via teclado com menus de seleção (Gems TTY).
- **Persistência de Dados**: Salvamento automático de relatórios detalhados em `.txt` e base de dados estruturada em `.csv`.
- **Gestão de Histórico**: Visualização de registros em tabelas formatadas com alinhamento dinâmico.
- **Busca e Exclusão**: Localização rápida de clientes e limpeza de registros por nome.
- **Blindagem de Dados**: Validações rigorosas para peso, altura, idade e sexo, impedindo entradas inconsistentes.

## 🛠️ Tecnologias e Bibliotecas

O projeto utiliza o **Ruby 3.x** e as seguintes Gems para uma experiência de usuário superior:

- [tty-prompt](https://github.com/piotrmurach/tty-prompt): Para menus interativos e capturas de dados validadas.
- [tty-table](https://github.com/piotrmurach/tty-table): Para renderização de tabelas Unicode no terminal.

## 📦 Instalação e Execução

1. **Clone o repositório:**
   ```bash
   git clone [https://github.com/seu-usuario/biostats.git](https://github.com/seu-usuario/biostats.git)
   cd biostats
