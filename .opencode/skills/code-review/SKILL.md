---
name: code-review
description: Revisão de código estruturada com checklist multi-dimensional e scoring de confiança para filtrar falsos positivos
license: MIT-0
compatibility: opencode
metadata:
  audience: developers
  workflow: review
---

# Code Review Skill

Skill para revisão de código sistemática com foco em qualidade, segurança e manutenibilidade.

## Quando Usar

Use esta skill quando:
- Precisar fazer code review de PRs ou branches
- Revisar mudanças antes de fazer commit
- Analisar código para identificar problemas potenciais
- Avaliar qualidade de código de terceiros

## Checklist de Review

Execute a revisão seguindo estas categorias:

### 1. Correção (Correctness)

- [ ] A lógica resolve o problema proposto?
- [ ] Edge cases estão tratados?
- [ ] Inputs inválidos são rejeitados adequadamente?
- [ ] Retornos são consistentes (não mistura null/undefined/throw)?

### 2. Segurança (Security)

- [ ] Sem injection (SQL, command, XSS)?
- [ ] Sem secrets hardcoded?
- [ ] Inputs são sanitizados/validados?
- [ ] Sem uso de `eval()`, `innerHTML`, `dangerouslySetInnerHTML`?

### 3. Performance

- [ ] Sem loops desnecessários ou complexidade O(n²)?
- [ ] Sem re-renders desnecessários (React)?
- [ ] Queries são otimizadas (N+1, índices)?
- [ ] Sem memory leaks (event listeners, timers)?

### 4. Manutenibilidade (Maintainability)

- [ ] Nomes de variáveis/funções são descritivos?
- [ ] Funções têm responsabilidade única (SRP)?
- [ ] Sem magic numbers — constantes nomeadas?
- [ ] Código duplicado foi extraído?

### 5. Tipagem (TypeScript)

- [ ] Sem `any` desnecessário?
- [ ] Interfaces/types estão definidos?
- [ ] Generics usados quando apropriado?
- [ ] Union types ao invés de booleans para estados?

### 6. Testes

- [ ] Mudança tem teste correspondente?
- [ ] Testes cobrem happy path + edge cases?
- [ ] Mocks não escondem bugs reais?
- [ ] Assertions são específicas?

## Scoring de Confiança

Classifique cada issue encontrada:

| Nível         | Confiança | Ação                          |
| ------------- | --------- | ------------------------------|
| 🔴 Crítico    | >90%      | Bloqueia merge                |
| 🟡 Importante | 70-90%    | Revisar antes do merge        |
| 🟢 Sugestão   | 50-70%    | Nice to have                  |
| ⚪ Nit        | <50%      | Ignorar se não concordar      |

## Template de Feedback

```markdown
### [🔴/🟡/🟢/⚪] Título curto do problema

**Arquivo:** `path/to/file.ts:42`
**Categoria:** Segurança | Performance | Correção | Manutenibilidade
**Confiança:** X%

**Problema:** Descrição do que está errado e por quê.

**Sugestão:**
```typescript
// código sugerido
```
```

## Como Executar

1. Use `git diff` ou `git diff --cached` para ver mudanças
2. Para cada arquivo modificado, aplique o checklist acima
3. Classifique cada issue com nível de confiança
4. Compile o feedback usando o template
5. Retorne o resumo com contagem por categoria

## Ferramentas Úteis

- `git diff <file>` - Ver mudanças em arquivo específico
- `git diff main...HEAD` - Ver mudanças desde main
- `git blame <file>` - Ver histórico de authorship
- `grep -n "pattern" <file>` - Buscar padrões específicos
