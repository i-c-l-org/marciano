<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecosistema Doutor/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com


# Guia Git — Referência do Dia a Dia

---

## Inspeção e Histórico

### Log visual e compacto

```bash
git log --oneline --graph --all --decorate
```
Exibe o histórico de commits em formato de árvore, ideal para visualizar branches.

### Ver o que mudou em um commit específico

```bash
git show <hash>
```

### Buscar em qual commit uma string apareceu

```bash
git log -S "texto que você procura" --oneline
```

### Ver quem alterou cada linha de um arquivo

```bash
git blame <arquivo>
```

### Histórico de um arquivo específico

```bash
git log --follow -p <arquivo>
```
O `--follow` rastreia renomeações do arquivo.

### Ver autor de cada commit (nome e email)

```bash
git log --oneline --format="%h %an <%ae> %s"
```
Útil para confirmar qual identidade está sendo usada nos commits.

---

## Branches

### Listar branches remotas e locais

```bash
git branch -a
```

### Deletar branch local e remota de uma vez

```bash
git branch -d minha-branch
git push origin --delete minha-branch
```

### Renomear branch atual

```bash
git branch -m novo-nome
```

### Criar e já mudar para nova branch

```bash
git switch -c minha-feature
```

---

## Identidade e Autoria

### Configurar identidade global (vale para todos os repositórios)

```bash
git config --global user.name "seu-usuario"
git config --global user.email "seu-email@exemplo.com"
```

### Configurar identidade local (apenas no repositório atual)

```bash
git config user.name "seu-usuario"
git config user.email "seu-email@exemplo.com"
```
Tem prioridade sobre a configuração global.

### Ver todas as configurações ativas

```bash
git config --list
```

---

## Correções e Ajustes

### Corrigir a mensagem do último commit

```bash
git commit --amend -m "Nova mensagem correta"
```

### Adicionar arquivo esquecido ao último commit (sem mudar mensagem)

```bash
git add arquivo-esquecido.js
git commit --amend --no-edit
```

### Desfazer o último commit mantendo as alterações

```bash
git reset --soft HEAD~1
```

### Desfazer TODOS os commits mantendo os arquivos

```bash
git reset $(git rev-list --max-parents=0 HEAD)
```
Volta até o primeiro commit da história. O código permanece intacto, apenas o histórico é apagado. Útil para recomeçar o histórico com a identidade correta.

### Descartar alterações de um arquivo específico

```bash
git restore <arquivo>
```

### Remover arquivo do stage sem perder as edições

```bash
git restore --staged <arquivo>
```

---

## Stash

### Salvar trabalho em progresso com nome

```bash
git stash push -m "wip: ajuste no formulário"
```

### Listar e aplicar um stash específico

```bash
git stash list
git stash apply stash@{2}
```

---

## Sincronização e Remotos

### Baixar atualizações sem aplicar (inspecionar antes)

```bash
git fetch origin
git diff HEAD origin/main
```

### Puxar com rebase (evita commits de merge desnecessários)

```bash
git pull --rebase origin main
```

### Trocar a URL remota (ex: de HTTPS para SSH)

```bash
git remote set-url origin git@github.com:usuario/repositorio.git
```

### Ver a URL remota atual

```bash
git remote -v
```

---

## SSH e Credenciais

### Gerar chave SSH para o GitHub

```bash
ssh-keygen -t ed25519 -C "seu-email@exemplo.com" -f ~/.ssh/github_nome
```

### Iniciar o SSH Agent e adicionar a chave

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github_nome
```

### Testar autenticação SSH com o GitHub

```bash
ssh -T git@github.com
```
Resposta esperada: `Hi seu-usuario! You've successfully authenticated...`

### Listar chaves carregadas no agent

```bash
ssh-add -l
```

### Remover credenciais HTTPS salvas

```bash
git config --global --unset credential.helper
git credential-cache exit
```

### Encontrar todos os repositórios Git na máquina

```bash
find ~ -name ".git" -type d 2>/dev/null
```
Útil para migrar múltiplos repos de HTTPS para SSH de uma vez.

---

## Utilitários Avançados

### Encontrar o commit que introduziu um bug (busca binária)

```bash
git bisect start
git bisect bad           # commit atual tem o bug
git bisect good <hash>   # hash onde estava funcionando
```
O Git navega automaticamente pelos commits até isolar o culpado.

### Aplicar um commit específico de outra branch

```bash
git cherry-pick <hash>
```
Muito útil para trazer um hotfix de uma branch para outra sem merge completo.

---

> 💡 **Dica:** crie aliases para os comandos mais usados no seu `~/.gitconfig`:
>
> ```bash
> git config --global alias.lg "log --oneline --graph --all --decorate"
> git config --global alias.st "status -sb"
> git config --global alias.undo "reset --soft HEAD~1"
> ```
>
> Assim você roda `git lg`, `git st` e `git undo` no lugar dos comandos longos.

