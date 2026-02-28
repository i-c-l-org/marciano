<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecossistema Agents/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com

---
name: commit-workflow
description: Conventional commits e git workflow para mensagens consistentes e trunk-based development
license: MIT-0
compatibility: opencode
metadata:
  audience: developers
  workflow: git
---

# Commit Workflow Skill

Skill para workflow de git com conventional commits e boas práticas.

## Conventional Commits

Formato:
```
<tipo>(<escopo>): <descrição>

[corpo opcional]

[footer opcional]
```

### Tipos

| Tipo | Descrição |
|------|------------|
| feat | Nova funcionalidade |
| fix | Bug fix |
| docs | Documentação |
| style | Formatação, lint |
| refactor | Refatoração |
| test | Testes |
| chore | Tarefas de manutenção |
| perf | Performance |
| ci | CI/CD |
| revert | Reverter commit |

### Exemplos

```
feat(auth): add login with OAuth2
fix(api): handle null response in user endpoint
docs(readme): update installation instructions
refactor(utils): extract validation to separate module
fix: resolve race condition in cache
```

### Regras

- Use imperative mood: "add" not "added"
- Max 72 chars no header
- Corpo em português ou inglês consistente
- Referencie issues: fixes #123, closes #456

## Workflow

### 1. Antes de Commitar
```bash
# Verificar status
git status

# Verificar mudanças
git diff

# Verificar staged
git diff --cached
```

### 2. Stage Seletivo
```bash
# Stage por arquivo
git add arquivo1 arquivo2

# Stage por patch
git add -p

# Stage por diretório
git add src/
```

### 3. Conventional Commit
```bash
git commit -m "feat(api): add user endpoint"
```

### 4. Verificar Antes de Push
- [ ] Tests passando
- [ ] Lint passando
- [ ] Mensagem follows conventional commits
- [ ] Commits are atomic

## Branch Naming

| Tipo | Padrão | Exemplo |
|------|--------|---------|
| Feature | `feature/<ticket>-description` | `feature/123-user-login` |
| Bugfix | `bugfix/<ticket>-description` | `bugfix/456-fix-crash` |
| Hotfix | `hotfix/<description>` | `hotfix/security-patch` |
| Release | `release/v1.2.0` | `release/v1.2.0` |

## Comandos Úteis

```bash
# Unstage
git reset HEAD arquivo

# Amend (se ainda não publicou)
git commit --amend

# Rebase interativo (squash, reword)
git rebase -i HEAD~3

# Stash
git stash push -m "mensagem"
git stash pop

# Cherry-pick
git cherry-pick <commit>

# Bisect (encontrar bug)
git bisect start
git bisect bad
git bisect good <commit>
```

## Checklist Pré-Push

- [ ] Commits follows conventional format
- [ ] No secrets committed
- [ ] Tests passing
- [ ] Lint passing
- [ ] Code formatted
- [ ] No merge conflicts

##快速命令

```bash
# Setup git alias para conventional commits
git config --global alias.cm 'commit -m'
git config --global alias.cm! 'commit --amend -m'

# Log bonito
git log --oneline --graph -20
```
