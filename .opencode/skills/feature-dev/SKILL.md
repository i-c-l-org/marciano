<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecossistema Agents/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com

---
name: feature-dev
description: Workflow estruturado de 7 fases para desenvolvimento de features com análise, design e implementação
license: MIT-0
compatibility: opencode
metadata:
  audience: developers
  workflow: development
---

# Feature Development Skill

Workflow sistemático para desenvolvimento de features, garantindo qualidade e integração adequada.

## Fases do Desenvolvimento

### Fase 1: Entendimento do Contexto
- Leia o requisito ou ticket da feature
- Identifique arquivos relevantes no codebase
- Pergunte clarifying questions se necessário
- Documente o entendimento esperado

### Fase 2: Análise do Codebase
- Explore a estrutura do projeto
- Identifique padrões existentes (nomenclatura, arquitetura)
- Encontre arquivos relacionados à feature
- Verifique testes existentes para referências

### Fase 3: Design da Solução
- Proponha uma arquitetura/solução
- Defina interfaces/types necessários
- Considere edge cases
- Documente decisões de design

### Fase 4: Implementação
- Siga os padrões do projeto
- Use nomes descritivos
- Adicione comentários apenas se necessário
- Mantenha funções pequenas e SRP

### Fase 5: Testes
- Escreva testes para a nova funcionalidade
- Cubra happy path e edge cases
- Execute testes existentes para garantir que não quebrou nada

### Fase 6: Review Interno
- Revise suas próprias mudanças
- Use a skill code-review para auto-avaliação
- Corrija issues encontradas

### Fase 7: Finalização
- Garanta que código está formatado
- Execute linter/typecheck
- Verifique se commits estão prontos

## Quando Usar

Use esta skill quando:
- Precisar implementar uma nova feature
- Trabalhar em refactoring significativo
- Adicionar nova funcionalidade ao projeto

## Estrutura de Resposta

Ao longo do desenvolvimento, mantenha o usuário informado:

```markdown
## Fase X: [Nome da Fase]

### O que estou fazendo:
[Descrição da tarefa atual]

### Decisões tomadas:
- [Decisão 1]
- [Decisão 2]

### Próximos passos:
1. [Próxima tarefa]
```

## Princípios

- **Incremental**: Entregue valor em pequenas partes
- **Testável**: Escreva código fácil de testar
- **Limpo**: Siga os padrões do projeto
- **Comunicativo**: Mantenha o usuário informado

## Ferramentas Úteis

- `glob` - Encontrar arquivos por padrão
- `grep` - Buscar no código
- `read` - Ler arquivos existentes
- `edit/write` - Fazer mudanças
- `bash` - Executar comandos (testes, build, etc)
