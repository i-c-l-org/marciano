<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecosistema Doutor/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com


# ✏️ Aider — Agente de Coding via Terminal

## O que é

Aider é um agente de IA para terminal que edita seus arquivos de código diretamente, faz commits automáticos e entende o contexto do seu projeto via git.

## Pré-requisitos

- Python 3.10+
- pipx instalado

## Instalação

```bash
# 1. Instala o pipx (necessário em Ubuntu/Debian 24+)
sudo apt install pipx -y

# 2. Garante que o pipx está no PATH
pipx ensurepath

# 3. Recarrega o terminal
source ~/.bashrc

# 4. Instala o Aider
pipx install aider-chat

# 5. Verifica
aider --version
```

> **Por que pipx?** O Ubuntu/Debian 24+ bloqueia instalação direta de pacotes Python com `pip` para proteger o sistema. O `pipx` cria um ambiente virtual isolado automaticamente.

## Iniciar o Aider

```bash
cd meu-projeto/
aider --model NOME_DO_MODELO
```

## Exemplos de uso

```bash
# Com modelo local (Ollama)
aider --model ollama/qwen2.5-coder:7b

# Com Gemini gratuito
aider --model gemini/gemini-2.5-flash

# Com Groq gratuito (mais rápido)
aider --model groq/llama-3.3-70b-versatile

# Modo autônomo (sem pedir confirmação)
aider --model gemini/gemini-2.5-flash --yes-always
```

## Comandos dentro do Aider

| Comando | O que faz |
|---|---|
| `/add arquivo.py` | Adiciona arquivo ao contexto |
| `/drop arquivo.py` | Remove arquivo do contexto |
| `/run pytest` | Executa comando shell |
| `/commit` | Força um commit git |
| `/help` | Lista todos os comandos |
| `/exit` | Sai do Aider |

## Configuração permanente (~/.aider.conf.yml)

Crie o arquivo para não precisar passar flags toda vez:

```yaml
model: gemini/gemini-2.5-flash
auto-commits: true
dark-mode: true
```

## Modo autônomo estilo Ralph

Para rodar tarefas sem interação (equivalente ao Ralph do Claude Code):

```bash
aider --model gemini/gemini-2.5-flash \
  --yes-always \
  --message "implemente todos os requisitos do arquivo REQUIREMENTS.md"
```

## Atualizar o Aider

```bash
pipx upgrade aider-chat
```

