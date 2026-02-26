<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecosistema Doutor/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com


# 🧰 Dev Toolkit

Toolkit de desenvolvimento pronto para clonar e usar. Skills pré-prontas, guias de referência, scripts utilitários e plugins curados — tudo organizado com boas práticas.

## Quick Start

```bash
git clone <repo-url> utils
cd utils
npm install
```

## 📂 Estrutura

```
utils/
├── docs/          📚 Guias de referência (git, npm, ollama, aider, etc)
├── skills/        🧠 Skills pré-prontas para agentes de IA
├── scripts/       🔧 Scripts utilitários (SSH setup, etc)
├── plugins/       🔌 Plugins Claude Code curados
└── tools/         🛠️ Ferramentas standalone (flowchart, etc)
```

## 📚 Documentação

| Guia                                         | Descrição                      |
| -------------------------------------------- | ------------------------------ |
| [Git Essentials](docs/git-essentials.md)     | Comandos Git do dia a dia      |
| [NPM Essentials](docs/npm-essentials.md)     | Manutenção de projetos Node.js |
| [Ollama Setup](docs/ollama-setup.md)         | Modelos de IA local            |
| [Aider Setup](docs/aider-setup.md)           | Agente de coding via terminal  |
| [Cloud Models](docs/cloud-models.md)         | Gemini e Groq gratuitos        |
| [Terminal Aliases](docs/terminal-aliases.md) | Atalhos de produtividade       |
| [DevContainer](docs/devcontainer.md)         | Ambientes isolados             |

## 🧠 Skills

Skills prontas para usar com agentes de IA ou como referência manual:

| Skill                                      | Uso                                         |
| ------------------------------------------ | ------------------------------------------- |
| [Code Review](skills/code-review/)         | Checklist estruturado de review com scoring |
| [Commit Workflow](skills/commit-workflow/) | Conventional commits e git workflow         |
| [Feature Dev](skills/feature-dev/)         | Desenvolvimento de features em 7 fases      |
| [Security Check](skills/security-check/)   | Checklist de segurança para código          |
| [PR Review](skills/pr-review/)             | Review de PRs em 6 dimensões                |
| [Project Setup](skills/project-setup/)     | Setup de novo projeto Node/TS               |

## 🔧 Scripts

```bash
# Setup SSH para GitHub (interativo — funciona com qualquer conta)
bash scripts/setup-github-ssh.sh

# Ou com argumentos diretos
bash scripts/setup-github-ssh.sh --user meu-user --email meu@email.com
```

## 🔌 Plugins

Plugins curados do Claude Code:

| Plugin            | Descrição                       |
| ----------------- | ------------------------------- |
| code-review       | Review automatizado de PRs      |
| commit-commands   | Automação de git commit/push/PR |
| feature-dev       | Workflow guiado de features     |
| frontend-design   | Design de interfaces premium    |
| hookify           | Criar hooks customizados        |
| pr-review-toolkit | Toolkit completo de review      |
| security-guidance | Alertas de segurança            |

## 📋 Prometheus (CLI)

O toolkit usa o [Prometheus](https://github.com/i-c-l-5-5-5) como CLI principal:

```bash
npm run diagnosticar       # Análise de qualidade
npm run formatar           # Formatação automática
npm run scan               # Scan de licenças
npm run guardian            # Verificação de segurança
```

## License

MIT-0

