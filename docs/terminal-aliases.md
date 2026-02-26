<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecosistema Doutor/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com


# ⚡ Atalhos de Terminal

Adicione os aliases abaixo no final do seu `~/.bashrc` para iniciar as ferramentas com comandos curtos.

## Como configurar

```bash
nano ~/.bashrc
```

Cole o bloco abaixo no final do arquivo:

```bash
# ── Aider — Modelos na Nuvem ────────────────────────
alias aider-gemini='aider --model gemini/gemini-2.5-pro'
alias aider-flash='aider --model gemini/gemini-2.5-flash'
alias aider-groq='aider --model groq/llama-3.3-70b-versatile'

# ── Aider — Modelo Local (Ollama) ───────────────────
alias aider-local='aider --model ollama/qwen2.5-coder:7b'
alias aider-local14='aider --model ollama/qwen2.5-coder:14b'

# ── Modo Autônomo (sem confirmações) ────────────────
alias aider-auto='aider --model gemini/gemini-2.5-flash --yes-always'
alias aider-auto-groq='aider --model groq/llama-3.3-70b-versatile --yes-always'

# ── Ollama ──────────────────────────────────────────
alias ollama-start='sudo systemctl start ollama'
alias ollama-stop='sudo systemctl stop ollama'
alias ollama-restart='sudo systemctl restart ollama'
alias ollama-status='systemctl status ollama'
alias ollama-modelos='ollama list'
```

Salve com `Ctrl+O`, `Enter`, `Ctrl+X` e recarregue:

```bash
source ~/.bashrc
```

## Referência rápida

| Comando | O que faz |
|---|---|
| `aider-gemini` | Aider com Gemini 2.5 Pro |
| `aider-flash` | Aider com Gemini 2.5 Flash (mais rápido) |
| `aider-groq` | Aider com Groq Llama 3.3 (mais rápido ainda) |
| `aider-local` | Aider com Qwen 7b local (offline) |
| `aider-local14` | Aider com Qwen 14b local (melhor qualidade) |
| `aider-auto` | Modo autônomo com Gemini Flash |
| `aider-auto-groq` | Modo autônomo com Groq |
| `ollama-start` | Inicia o serviço Ollama |
| `ollama-stop` | Para o serviço Ollama |
| `ollama-status` | Verifica se o Ollama está rodando |
| `ollama-modelos` | Lista modelos instalados |

## Uso típico

```bash
# Entra no projeto
cd meu-projeto/

# Inicia o agente com Groq (gratuito + rápido)
aider-groq

# Ou em modo autônomo para uma tarefa específica
aider-auto --message "crie testes unitários para todos os arquivos Python"
```

