<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecosistema Doutor/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com


---
name: Go Dev Workflow
description: Workflow completo de desenvolvimento Go: build, test, debug e deploy
---

# Go Dev Workflow

Workflow completo para desenvolvimento Go produtivo.

## 1. Comandos Básicos

```bash
# Build
go build ./...
go build -o bin/app cmd/app/main.go

# Run
go run ./cmd/app

# Install
go install ./cmd/app

# Vet (análise estática)
go vet ./...

# Format
go fmt ./...
goimports -w .
```

## 2. Dependências

```bash
# Adicionar dependência
go get github.com/gin-gonic/gin@v1.9.1

# Atualizar
go get -u ./...

# Remover não usadas
go mod tidy

# Verificar vulnerabilidades
go run golang.org/x/vuln/cmd/govulncheck@latest ./...

# Listar
go list -m all
go mod graph
```

## 3. Testes

### Executar

```bash
# Todos os testes
go test ./...

# Verbose
go test -v ./...

# Coverage
go test -cover ./...
go test -coverprofile=coverage.out && go tool cover -html=coverage.out

# Race condition detector
go test -race ./...

# Benchmarks
go test -bench=. -benchmem ./...

# Executar teste específico
go test -run TestNomeDoTeste ./...

# Watch mode
gotestsum -- -watch ./...
```

### Tabela de Testes

```go
func TestSoma(t *testing.T) {
    tests := []struct {
        name     string
        a, b     int
        expected int
    }{
        {"simples", 2, 3, 5},
        {"negativos", -1, -1, -2},
        {"zero", 0, 0, 0},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            result := Soma(tt.a, tt.b)
            if result != tt.expected {
                t.Errorf("Soma(%d, %d) = %d; want %d", tt.a, tt.b, result, tt.expected)
            }
        })
    }
}
```

### T.Bench

```go
func BenchmarkSoma(b *testing.B) {
    for i := 0; i < b.N; i++ {
        Soma(1, 2)
    }
}
```

## 4. Debugging

### Delve

```bash
go install github.com/go-delve/delve/cmd/dlv@latest

# Iniciar debug
dlv debug ./cmd/app

# Com breakpoints
(dlv) break main.main
(dlv) continue
(dlv) print variavel
(dlv) next
(dlv) quit
```

### VS Code

```json
{
  "configurations": [
    {
      "name": "Launch",
      "type": "go",
      "request": "launch",
      "mode": "debug",
      "program": "${workspaceFolder}/cmd/app",
      "env": {
        "ENV": "development"
      }
    }
  ]
}
```

### Log

```go
import (
    "log"
    "log/slog"
)

// Básico
log.Println("info")

// Structured (Go 1.21+)
slog.Info("mensagem", "key", "value")
slog.Error("erro", "err", err)
```

## 5. Linting e Quality

### golangci-lint

```bash
# Instalar
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Rodar
golangci-lint run ./...

# Configuração
golangci-lint run --config .golangci.yml ./...
```

### .golangci.yml

```yaml
run:
  timeout: 5m
  modules-download-mode: readonly

linters:
  enable:
    - errcheck
    - gosimple
    - govet
    - ineffassign
    - staticcheck
    - typecheck
    - unused
    - gofmt
    - goimports

linters-settings:
  errcheck:
    check-type-assertions: true
  govet:
    enable-all: true
```

### Pre-commit

```yaml
repos:
  - repo: https://github.com/golangci/golangci-lint-action
    rev: v5.0.0
    hooks:
      - id: golangci-lint
```

## 6. Concorrência

### Goroutines

```go
func worker(id int, jobs <-chan int, results chan<- int) {
    for j := range jobs {
        results <- j * 2
    }
}

func main() {
    jobs := make(chan int, 100)
    results := make(chan int, 100)

    for w := 1; w <= 3; w++ {
        go worker(w, jobs, results)
    }

    for j := 1; j <= 9; j++ {
        jobs <- j
    }
    close(jobs)

    for a := 1; a <= 9; a++ {
        <-results
    }
}
```

### sync.WaitGroup

```go
var wg sync.WaitGroup

for _, task := range tasks {
    wg.Add(1)
    go func(t string) {
        defer wg.Done()
        process(t)
    }(task)
}

wg.Wait()
```

### Context

```go
func longRunningTask(ctx context.Context) error {
    select {
    case <-time.After(5 * time.Second):
        return nil
    case <-ctx.Done():
        return ctx.Err()
    }
}

ctx, cancel := context.WithTimeout(context.Background(), 2*time.Second)
defer cancel()
```

### sync.Mutex

```go
type SafeCounter struct {
    mu    sync.Mutex
    value int
}

func (c *SafeCounter) Inc() {
    c.mu.Lock()
    defer c.mu.Unlock()
    c.value++
}
```

## 7. Database

### SQLx

```go
import "github.com/jmoiron/sqlx"

var db *sqlx.DB

func init() {
    db = sqlx.Connect("postgres", "user=postgres dbname=postgres sslmode=disable")
}

func GetUsers() ([]User, error) {
    var users []User
    err := db.Select(&users, "SELECT * FROM users")
    return users, err
}
```

### Migrate

```bash
go install github.com/golang-migrate/migrate/v4/cmd/migrate@latest

migrate -path migrations -database postgres://localhost:5432/db up
migrate -path migrations -database postgres://localhost:5432/db down
```

## 8. Build e Deploy

### Multi-platform

```bash
# Linux
GOOS=linux GOARCH=amd64 go build -o bin/app-linux

# Windows
GOOS=windows GOARCH=amd64 go build -o bin/app.exe

# macOS
GOOS=darwin GOARCH=arm64 go build -o bin/app-mac

# Todas plataformas
GOOS=linux GOARCH=amd64 go build -o bin/app-linux && \
GOOS=windows GOARCH=amd64 go build -o bin/app.exe && \
GOOS=darwin GOARCH=arm64 go build -o bin/app-mac
```

### Docker

```dockerfile
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/bin/app ./cmd/app

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /app/bin/app /app/
CMD ["/app/app"]
```

### Makefile

```makefile
.PHONY: build test lint run

build:
	go build -o bin/app ./cmd/app

test:
	go test -v -race ./...

test-coverage:
	go test -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out

lint:
	golangci-lint run ./...

run:
	go run ./cmd/app

clean:
	rm -rf bin/ coverage.out
```

## Checklist de Qualidade

- [ ] Build passando (`go build`)
- [ ] Testes passando (`go test`)
- [ ] Linting limpo (`golangci-lint`)
- [ ] Sem race conditions (`go test -race`)
- [ ] Cobertura adequada
- [ ] Context usado corretamente
- [ ] Erros tratados
- [ ] Documentação atualizada
