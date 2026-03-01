<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecosistema Doutor/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com


# Docker Fundamentals

Guia completo de Docker para desenvolvedores.

## 1. Comandos Básicos

```bash
# Listar containers
docker ps
docker ps -a

# Listar imagens
docker images

# Executar container
docker run nginx
docker run -d nginx  # detached
docker run -p 8080:80 nginx  # port mapping
docker run -v /path:/container/path nginx  # volume
docker run --name my-nginx nginx  # nomear
docker run -e VAR=value nginx  # env vars

# Parar/Iniciar
docker stop container_id
docker start container_id

# Remover
docker rm container_id
docker rmi image_id

# Logs
docker logs container_id
docker logs -f container_id  # follow

# Executar comando no container
docker exec -it container_id bash
docker exec container_id cat /etc/hosts
```

## 2. Dockerfile

### Estrutura Básica

```dockerfile
# Base image
FROM node:20-alpine

# Metadata
LABEL maintainer="email@example.com"

# Working directory
WORKDIR /app

# Copy files
COPY package*.json ./
COPY . .

# Install dependencies
RUN npm ci --only=production

# Expose port
EXPOSE 3000

# Environment variables
ENV NODE_ENV=production

# Entrypoint
CMD ["node", "index.js"]
```

### Multi-stage Build

```dockerfile
# Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM node:20-alpine AS production
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

### Python

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "main.py"]
```

### Go

```dockerfile
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o app

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=builder /app/app .
CMD ["./app"]
```

## 3. Docker Compose

### docker-compose.yml

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
      - DB_HOST=postgres
    depends_on:
      - postgres
      - redis
    volumes:
      - .:/app
      - /app/node_modules

  postgres:
    image: postgres:15-alpine
    environment:
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=mydb
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  postgres_data:
```

### Comandos Compose

```bash
# Iniciar todos os serviços
docker-compose up
docker-compose up -d  # detached

# Rebuild
docker-compose up --build

# Parar
docker-compose down

# Ver logs
docker-compose logs -f

# Executar comando em serviço
docker-compose exec app bash

# Scale
docker-compose up -d --scale app=3
```

## 4. Melhores Práticas

### Dockerfile Otimizado

```dockerfile
# Usar alpine
FROM node:20-alpine

# Multi-stage para build
FROM builder AS production

# Copiar apenas necessário
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules

# Usar usuário não-root
RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -G appgroup -s /bin/sh -D appuser
USER appuser

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --quiet --tries=1 --spider http://localhost:3000/health || exit 1
```

### .dockerignore

```
node_modules/
.git/
.gitignore
README.md
.env*
*.log
coverage/
dist/
build/
.vscode/
.idea/
Dockerfile
docker-compose.yml
```

## 5. Networking

```bash
# Criar rede
docker network create my-network

# Conectar container a rede
docker network connect my-network container_id

# Listar redes
docker network ls

# Inspect rede
docker network inspect my-network
```

```yaml
# docker-compose.yml com rede customizada
networks:
  frontend:
  backend:
    driver: bridge
```

## 6. Volumes

```bash
# Criar volume
docker volume create my-volume

# Listar volumes
docker volume ls

# Inspect volume
docker volume inspect my-volume
```

```yaml
# Named volume
volumes:
  my-data:
    driver: local

# Bind mount
volumes:
  - ./local/path:/container/path

# Read-only
volumes:
  - ./local/path:/container/path:ro
```

## 7. Debugging

```bash
# Acessar container
docker exec -it container_id /bin/sh

# Ver processos
docker top container_id

# Ver recursos
docker stats container_id

# Inspect
docker inspect container_id

# Verificar logs
docker logs --tail 100 container_id
docker logs --since 1h container_id
```

## 8. Exemplos Rápidos

### Node.js + MongoDB

```yaml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - MONGO_URI=mongodb://mongo:27017/mydb

  mongo:
    image: mongo:7
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db
```

### Nginx como Reverse Proxy

```yaml
version: '3.8'
services:
  nginx:
    image: nginx:latest
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./certs:/etc/nginx/certs:ro
    depends_on:
      - app
```

## Comandos Úteis

```bash
# Cleanup
docker system prune
docker container prune
docker image prune -a
docker volume prune

# Build com cache
docker build -t myapp .

# Tag e push
docker tag myapp:latest registry/myapp:v1.0.0
docker push registry/myapp:v1.0.0
```
