<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecosistema Doutor/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com


# Python Essentials

Guia de comandos e ferramentas essenciais para Python.

## 1. Ambiente Virtual

### venv (Built-in)

```bash
# Criar
python -m venv .venv

# Ativar Linux/Mac
source .venv/bin/activate

# Ativar Windows
.venv\Scripts\activate

# Desativar
deactivate
```

### uv (Moderno e Rápido)

```bash
# Install
pip install uv

# Criar ambiente
uv venv
uv venv .venv

# Ativar
source .venv/bin/activate

# Instalar dependências
uv pip install -r requirements.txt
uv pip install -e ".[dev]"

# Sync ambiente
uv pip sync requirements.txt
```

### pipx

```bash
# Install pipx
python -m pip install --user pipx
pipx install black
pipx install ruff
```

## 2. Gerenciamento de Pacotes

```bash
# Listar instalados
pip list
pip freeze

# Instalar
pip install package
pip install package==1.0.0
pip install "package>=1.0"

# Desinstalar
pip uninstall package

# Requisitos
pip freeze > requirements.txt
pip install -r requirements.txt

# Auditoria
pip audit
pip check
```

## 3. pyproject.toml

```toml
[project]
name = "meu-projeto"
version = "0.1.0"
description = "Descrição"
requires-python = ">=3.10"
dependencies = [
    "fastapi>=0.100.0",
    "uvicorn>=0.23.0",
    "pydantic>=2.0.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0.0",
    "ruff>=0.1.0",
    "mypy>=1.0.0",
]
test = [
    "pytest>=7.0.0",
    "pytest-cov>=4.0.0",
    "httpx>=0.24.0",
]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
```

## 4. Linting e Formatação

### Ruff (Linting + Formatting)

```bash
# Install
pip install ruff

# Check
ruff check .
ruff check . --select=E,F,W
ruff check . --ignore=E501

# Fix
ruff check . --fix

# Format
ruff format .
```

### Black

```bash
pip install black
black .
black --check .  # só verificar
black --diff .   # mostrar diff
```

### isort

```bash
pip install isort
isort .
isort --check-only .
```

### MyPy

```bash
pip install mypy
mypy .
mypy --strict .
mypy src/
```

### Configurações

```toml
# pyproject.toml
[tool.ruff]
target-version = "py310"
line-length = 100

[tool.ruff.lint]
select = ["E", "F", "W", "I", "N", "UP", "B", "C4"]
ignore = ["E501"]

[tool.mypy]
python_version = "3.10"
strict = true
warn_return_any = true
```

## 5. Testes

### pytest

```bash
pip install pytest pytest-cov

# Rodar
pytest
pytest tests/
pytest -v
pytest -k "test_name"
pytest -k "test_name and not slow"

# Coverage
pytest --cov=src --cov-report=html
pytest --cov=src --cov-report=term-missing
```

### Fixtures

```python
# conftest.py
import pytest
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

@pytest.fixture
def db_session():
    engine = create_engine("sqlite:///:memory:")
    Session = sessionmaker(bind=engine)
    session = Session()
    yield session
    session.close()

@pytest.fixture
def client():
    from fastapi import FastAPI
    # ...
```

### Parametrize

```python
@pytest.mark.parametrize("input,expected", [
    (1, 2),
    (2, 4),
    (3, 6),
])
def test_double(input, expected):
    assert double(input) == expected
```

## 6. Frameworks Web

### FastAPI

```bash
pip install fastapi uvicorn
```

```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

class Item(BaseModel):
    name: str
    price: float

@app.get("/")
async def root():
    return {"message": "Hello"}

@app.post("/items/")
async def create_item(item: Item):
    return item
```

```bash
uvicorn main:app --reload --port 8000
```

### Flask

```bash
pip install flask
```

```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def hello():
    return jsonify(message="Hello")

if __name__ == "__main__":
    app.run(debug=True)
```

## 7. Database

### SQLAlchemy

```bash
pip install sqlalchemy
```

```python
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker, declarative_base

Base = declarative_base()

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    name = Column(String)

engine = create_engine("sqlite:///app.db")
Base.metadata.create_all(engine)

Session = sessionmaker(bind=engine)
session = Session()

# CRUD
user = User(name="John")
session.add(user)
session.commit()
```

### Alembic (Migrations)

```bash
pip install alembic
alembic init migrations
```

```bash
alembic revision --autogenerate -m "add column"
alembic upgrade head
alembic downgrade -1
```

## 8. Scripts Úteis

```bash
# Virtualenv rápido
python -m venv venv && source venv/bin/activate && pip install -r requirements.txt

# Atualizar todos os pacotes
pip freeze > requirements.txt
pip install -U -r requirements.txt

# Remover semua packages
pip freeze | xargs pip uninstall -y

# Verificar vulnerabilidades
pip audit
pip install safety
safety check
```

## 9. Ferramentas de Produtividade

### httpie (HTTP client)

```bash
pip install httpie

http GET https://api.example.com/users
http POST https://api.example.com/users name=John
```

### rich (CLI prettier)

```bash
pip install rich
```

```python
from rich.console import Console
from rich.table import Table

console = Console()
table = Table("Name", "Age")
table.add_row("John", "30")
console.print(table)
```

### typer (CLI apps)

```bash
pip install typer
```

```python
import typer

def main(name: str, age: int = 18):
    print(f"Hello {name}, you are {age}")

if __name__ == "__main__":
    typer.run(main)
```

## 10. Comandos Rápidos

```bash
# Ver versão
python --version

# Executar script
python script.py

# REPL
python

# Módulo
python -m http.server 8000

# One-liners
python -c "print('Hello')"
python -c "import json; print(json.dumps({'a': 1}))"
```
