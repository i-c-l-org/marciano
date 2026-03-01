<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecosistema Doutor/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com


---
name: Python Project Setup
description: Setup de novo projeto Python com boas práticas, linting, testes e CI
---

# Python Project Setup

Checklist completo para iniciar um novo projeto Python com boas práticas desde o dia zero.

## 1. Inicialização

```bash
mkdir meu-projeto && cd meu-projeto
git init
```

### Ambiente Virtual

```bash
# Criar ambiente virtual
python -m venv .venv

# Ativar (Linux/Mac)
source .venv/bin/activate

# Ativar (Windows)
.venv\Scripts\activate
```

## 2. pyproject.toml (Recomendado)

```toml
[project]
name = "meu-projeto"
version = "0.1.0"
description = "Descrição do projeto"
requires-python = ">=3.10"
dependencies = [
    "fastapi>=0.100.0",
    "uvicorn>=0.23.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0.0",
    "pytest-cov>=4.0.0",
    "ruff>=0.1.0",
    "mypy>=1.0.0",
    "pre-commit>=3.0.0",
]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.ruff]
target-version = "py310"
line-length = 100

[tool.ruff.lint]
select = ["E", "F", "W", "I", "N", "UP", "B", "C4"]

[tool.mypy]
python_version = "3.10"
strict = true
warn_return_any = true

[tool.pytest.ini_options]
testpaths = ["tests"]
addopts = "--cov=src --cov-report=term-missing"
```

## 3. Instalação

```bash
# Instalar com dependências de desenvolvimento
pip install -e ".[dev]"

# Ou usar hatch
pip install hatch
hatch env create
```

## 4. Estrutura de Pastas

```
projeto/
├── src/
│   └── meu_projeto/
│       ├── __init__.py
│       └── main.py
├── tests/
│   └── test_main.py
├── pyproject.toml
├── .gitignore
├── .pre-commit-config.yaml
└── README.md
```

## 5. Linting e Formatação

```bash
pip install ruff black mypy
```

### Comandos

```bash
# Ruff - Linting rápido
ruff check .
ruff check . --fix

# Black - Formatação
black .

# MyPy - Type checking
mypy .
```

### pre-commit

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.1.0
    hooks:
      - id: ruff
        args: [--fix]
      - id: ruff-format
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.0.0
    hooks:
      - id: mypy
```

```bash
pip install pre-commit
pre-commit install
```

## 6. Testes

```bash
pip install pytest pytest-cov
```

### pytest.ini

```ini
[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py"]
python_functions = ["test_*"]
addopts = "-v --tb=short"
```

### Exemplo de Teste

```python
# tests/test_main.py
from src.meu_projeto import hello

def test_hello():
    assert hello("world") == "Hello, world!"
```

```bash
pytest
pytest --cov=src
```

## 7. Git

### .gitignore mínimo

```
__pycache__/
*.py[cod]
*$py.class
.venv/
venv/
env/
*.egg-info/
dist/
build/
.pytest_cache/
.mypy_cache/
.ruff_cache/
.coverage
htmlcov/
.env
.eggs/
*.egg
```

### Primeiro commit

```bash
git add .
git commit -m "chore: initial project setup"
```

## 8. Frameworks Populares

### FastAPI

```bash
pip install fastapi uvicorn
```

```python
# src/main.py
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Hello World"}
```

```bash
uvicorn src.main:app --reload
```

### Django

```bash
pip install django
django-admin startproject myproject .
python manage.py startapp myapp
```

### Flask

```bash
pip install flask
```

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World"
```

```bash
flask run --debug
```

## Checklist Final

- [ ] Ambiente virtual criado e ativado
- [ ] `pyproject.toml` configurado
- [ ] Dependências instaladas
- [ ] Estrutura de pastas criada
- [ ] Testes rodando (`pytest`)
- [ ] Linting passando (`ruff check`)
- [ ] Type checking passando (`mypy`)
- [ ] `.gitignore` completo
- [ ] pre-commit configurado
- [ ] README com instruções
- [ ] Primeiro commit feito
