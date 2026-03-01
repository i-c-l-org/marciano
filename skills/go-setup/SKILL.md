<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecosistema Doutor/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com


---
name: Go Project Setup
description: Setup de novo projeto Go com boas práticas, testing, linting e CI
---

# Go Project Setup

Checklist completo para iniciar um novo projeto Go com boas práticas desde o dia zero.

## 1. Instalação do Go

```bash
# Verificar instalação
go version

# Atualizar (Linux)
sudo apt update && sudo apt install golang-go

# Via go install (versão específica)
go install golang.org/dl/go1.21.0@latest
go1.21.0 download
```

## 2. Inicialização

```bash
mkdir meu-projeto && cd meu-projeto
git init
go mod init github.com/usuario/meu-projeto
```

### go.mod exemplo

```go
module github.com/usuario/meu-projeto

go 1.21

require (
	github.com/gin-gonic/gin v1.9.1
	github.com/stretchr/testify v1.8.4
)

require (
	github.com/bytedance/sonic v1.9.1 // indirect
	github.com/chenzhuoyu/base64x v0.0.0-20221115062448-fe3a3abad311 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/gabriel-vasile/mimetype v1.4.2 // indirect
	github.com/gin-contrib/sse v0.1.0 // indirect
	github.com/go-playground/locales v0.14.1 // indirect
	github.com/go-playground/universal-translator v0.18.1 // indirect
	github.com/go-playground/validator/v10 v10.14.0 // indirect
	github.com/goccy/go-json v0.10.2 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/klauspost/cpuid/v2 v2.2.4 // indirect
	github.com/leodido/go-urn v1.2.4 // indirect
	github.com/mattn/go-isatty v0.0.19 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/pelletier/go-toml/v2 v2.0.8 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/twitchyliquid64/golang-asm v0.15.1 // indirect
	github.com/ugorji/go/codec v1.2.11 // indirect
	golang.org/x/arch v0.3.0 // indirect
	golang.org/x/crypto v0.9.0 // indirect
	golang.org/x/net v0.10.0 // indirect
	golang.org/x/sys v0.8.0 // indirect
	golang.org/x/text v0.9.0 // indirect
	google.golang.org/protobuf v1.30.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)
```

## 3. Estrutura de Pastas

```
projeto/
├── cmd/
│   └── meu-projeto/
│       └── main.go
├── internal/
│   ├── handler/
│   ├── service/
│   └── repository/
├── pkg/
│   └── utils/
├── go.mod
├── go.sum
├── .gitignore
└── README.md
```

### .gitignore Go

```
# Binários
/bin/
/build/
/dist/

# Dependencies
vendor/

# IDE
.idea/
.vscode/
*.swp
*.swo

# OS
.DS_Store

# Test coverage
*.out
coverage.txt
```

## 4. Hello World

```go
// cmd/meu-projeto/main.go
package main

import (
    "fmt"
)

func main() {
    fmt.Println("Hello, World!")
}
```

```bash
go run cmd/meu-projeto/main.go
go build -o bin/meu-projeto cmd/meu-projeto/main.go
```

## 5. Dependências

```bash
# Adicionar dependência
go get github.com/gin-gonic/gin

# Atualizar todas
go get -u ./...

# Remover dependências não usadas
go mod tidy

# Listar dependências
go list -m all
```

## 6. Ferramentas de Desenvolvimento

### golangci-lint

```bash
# Instalar
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Rodar
golangci-lint run

# Configuração (golangci.yml)
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
```

### gopls (Language Server)

```bash
go install golang.org/x/tools/gopls@latest
```

Configuração VS Code:

```json
{
  "go.toolsManagement.autoUpdate": true,
  "go.lintTool": "golangci-lint",
  "go.lintOnSave": "package",
  "go.formatTool": "goimports"
}
```

## 7. Testes

### Teste Básico

```go
// internal/handler/handler_test.go
package handler

import (
    "testing"
)

func TestSoma(t *testing.T) {
    result := Soma(2, 3)
    expected := 5

    if result != expected {
        t.Errorf("esperado %d, obteve %d", expected, result)
    }
}
```

```bash
go test ./...
go test -v ./...
go test -cover ./...
```

### Testes com Mock

```go
import (
    "testing"
    "github.com/stretchr/testify/mock"
)

type MockRepo struct {
    mock.Mock
}

func (m *MockRepo) GetUser(id int) (*User, error) {
    args := m.Called(id)
    if args.Get(0) == nil {
        return nil, args.Error(1)
    }
    return args.Get(0).(*User), args.Error(1)
}

func TestGetUser(t *testing.T) {
    mockRepo := new(MockRepo)

    mockRepo.On("GetUser", 1).Return(&User{ID: 1, Name: "John"}, nil)

    service := NewService(mockRepo)
    user, err := service.GetUser(1)

    mockRepo.AssertExpectations(t)
    assert.NoError(t, err)
    assert.Equal(t, "John", user.Name)
}
```

## 8. Frameworks Populares

### Gin (Web)

```go
package main

import (
    "github.com/gin-gonic/gin"
)

func main() {
    r := gin.Default()

    r.GET("/ping", func(c *gin.Context) {
        c.JSON(200, gin.H{"message": "pong"})
    })

    r.Run()
}
```

### Fiber (Fiber)

```go
package main

import (
    "github.com/gofiber/fiber/v2"
)

func main() {
    app := fiber.New()

    app.Get("/", func(c *fiber.Ctx) error {
        return c.SendString("Hello, World!")
    })

    app.Listen(":3000")
}
```

### Chi (Router)

```go
package main

import (
    "github.com/go-chi/chi/v5"
    "github.com/go-chi/chi/v5/middleware"
    "net/http"
)

func main() {
    r := chi.NewRouter()
    r.Use(middleware.Logger)

    r.Get("/", func(w http.ResponseWriter, r *http.Request) {
        w.Write([]byte("Hello"))
    })

    http.ListenAndServe(":3000", r)
}
```

## Checklist Final

- [ ] Go instalado (`go version`)
- [ ] `go.mod` criado
- [ ] Estrutura de pastas definida
- [ ] Hello World rodando
- [ ] Dependências instaladas (`go get`)
- [ ] Linting configurado (`golangci-lint`)
- [ ] Testes rodando (`go test`)
- [ ] `.gitignore` completo
- [ ] README com instruções
- [ ] Primeiro commit feito
