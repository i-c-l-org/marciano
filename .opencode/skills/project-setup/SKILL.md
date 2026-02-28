<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecossistema Agents/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com

---
name: project-setup
description: Setup de novos projetos Node/TypeScript com estrutura, testes e ferramentas configuradas
license: MIT-0
compatibility: opencode
metadata:
  audience: developers
  workflow: setup
---

# Project Setup Skill

Skill para inicializar novos projetos com estrutura padronizada e tooling configurado.

## Setup Node/TypeScript

### 1. Inicialização

```bash
# Novo projeto
npm init -y

# ou com yarn
yarn init -y
```

### 2. TypeScript

```bash
# Install dev dependency
npm install -D typescript @types/node tsx

# ou com yarn
yarn add -D typescript @types/node tsx
```

### 3. tsconfig.json Recomendado

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "lib": ["ES2022"],
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "outDir": "./dist"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

### 4. Scripts package.json

```json
{
  "scripts": {
    "dev": "tsx watch src/index.ts",
    "build": "tsc",
    "start": "node dist/index.js",
    "test": "vitest",
    "test:ui": "vitest --ui",
    "lint": "eslint src --ext .ts",
    "format": "prettier --write \"src/**/*.ts\"",
    "typecheck": "tsc --noEmit"
  }
}
```

## Estrutura de Diretórios

```
project/
├── src/
│   ├── index.ts
│   ├── config/
│   ├── services/
│   ├── utils/
│   └── types/
├── tests/
│   └── ...
├── dist/
├── node_modules/
├── package.json
├── tsconfig.json
├── .gitignore
├── .eslintrc.json
└── .prettierrc
```

## Ferramentas Recomendadas

### Linting

```bash
npm install -D eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
```

### Formatting

```bash
npm install -D prettier
```

### Testing

```bash
npm install -D vitest @testing-library/react jsdom
```

### Git Hooks

```bash
npm install -D husky lint-staged
npx husky init
```

## Checklist de Setup

### Essencial

- [ ] package.json com name, version, type: module
- [ ] tsconfig.json configurado
- [ ] .gitignore (node_modules, dist, .env)
- [ ] Scripts de dev/build/test

### Qualidade

- [ ] ESLint configurado
- [ ] Prettier configurado
- [ ] Husky com pre-commit hook
- [ ] Tests configurados (Vitest)

### Git

- [ ] git init
- [ ] Initial commit
- [ ] .gitignore com entries corretas

## Variáveis de Ambiente

### .env.example

```
# API
API_KEY=
API_URL=

# Database
DATABASE_URL=

# Auth
JWT_SECRET=
```

### .gitignore

```
node_modules/
dist/
.env
.env.local
*.log
.DS_Store
```

## Após Setup

1. Execute `npm install`
2. Execute `npm run build` para verificar
3. Execute `npm test` para verificar
4. Faça primeiro commit
5. Configure CI/CD (GitHub Actions)
