---
name: security-check
description: Checklist de segurança para identificar vulnerabilidades comuns em código
license: MIT-0
compatibility: opencode
metadata:
  audience: developers
  workflow: security
---

# Security Check Skill

Skill para auditoria de segurança básica em código.

## Checklist de Segurança

### 1. Injection

- [ ] Sem SQL injection (use parameterized queries)
- [ ] Sem Command injection (evite shell=True, exec, system)
- [ ] Sem XSS (sanitize HTML input/output)
- [ ] Sem LDAP injection
- [ ] Sem XXE (XML External Entity)

### 2. Autenticação e Autorização

- [ ] Senhas hashadas (bcrypt, argon2, not MD5/SHA1)
- [ ] Tokens seguros (JWT com secret forte, exp)
- [ ] Session management seguro
- [ ] Verificação de permissão em endpoints

### 3. Dados Sensíveis

- [ ] Sem secrets no código (.env, config files)
- [ ] Sem credenciais hardcoded
- [ ] Dados sensíveis criptografados em trânsito (HTTPS)
- [ ] Dados sensíveis criptografados em repouso
- [ ] Logs não expõem dados sensíveis

### 4. Input Validation

- [ ] Todos os inputs validados
- [ ] Tipos verificados
- [ ] Tamanho limites respeitados
- [ ] Sanitização apropriada

### 5. Dependencies

- [ ] Dependencies atualizadas
- [ ] Sem vulnerabilidades conhecidas (npm audit, snyk)
- [ ] License apropriada

### 6. Configuração

- [ ] CORS configurado corretamente
- [ ] Headers de segurança (CSP, HSTS, X-Frame-Options)
- [ ] Error messages não expõem stack traces
- [ ] Modo debug desabilitado em produção

### 7. Práticas Seguras

- [ ] Sem uso de eval()
- [ ] Sem uso de innerHTML não sanitizado
- [ ] Path traversal verificado
- [ ] Rate limiting implementado
- [ ] CSRF tokens quando aplicável

## Como Executar

1. Use `grep` para buscar padrões perigosos:
   ```bash
   grep -rn "eval(" .
   grep -rn "innerHTML" .
   grep -rn "password\s*=" .
   grep -rn "secret\|key\|token" --include="*.ts" --include="*.js" .
   ```

2. Revise arquivos de configuração:
   - package.json (scripts, dependencies)
   - .env.example
   - config files

3. Verifique dependências:
   ```bash
   npm audit
   ```

4. Aplique o checklist acima

## Vulnerabilidades Comuns

| Tipo | Padrão Perigoso | Alternativa |
|------|-----------------|-------------|
| SQL Injection | `query("SELECT * FROM users WHERE id = " + id)` | Parameterized queries |
| XSS | `element.innerHTML = userInput` | textContent, sanitize |
| Command Injection | `os.system("ls " + userInput)` | subprocess.run com lista |
| Path Traversal | `open("uploads/" + filename)` | validate, sanitize path |
| Weak Crypto | `hashlib.md5(data)` | hashlib.sha256, bcrypt |

## Saída Esperada

Retorne um relatório com:

```markdown
# Security Audit Report

## Vulnerabilidades Críticas 🔴
- [ ] [Descrição] - [Arquivo:linha]

## Vulnerabilidades Médias 🟡
- [ ] [Descrição] - [Arquivo:linha]

## Recomendações 🟢
- [ ] [Descrição]

## Limitações
[O que não foi possível verificar]
```

## Quando Usar

- Antes de merge de PRs
- Auditoria de segurança periódica
- Após incidentes
- Em código de terceiros
