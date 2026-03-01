<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecosistema Doutor/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com


---
name: Python Dev Workflow
description: Workflow completo de desenvolvimento Python: debug, teste, refactor e deploy
---

# Python Dev Workflow

Workflow completo para desenvolvimento Python produtivo.

## 1. Ambiente de Desenvolvimento

### Ativação Rápida

```bash
# Ativar ambiente virtual
source .venv/bin/activate  # Linux/Mac
.venv\Scripts\activate     # Windows

# Verificar ambiente ativo
which python  # Linux/Mac
where python  # Windows
```

### Dependências

```bash
# Instalar todas as dependências
pip install -e ".[dev]"

# Atualizar dependências
pip install -U -e ".[dev]"

# Freeze para produção
pip freeze > requirements.txt
```

## 2. Execução

### Scripts

```bash
# Script simples
python script.py

# Módulo
python -m src.meu_modulo

# Com argumentos
python script.py --verbose --input file.txt
```

### FastAPI

```bash
# Desenvolvimento com hot reload
uvicorn src.main:app --reload --port 8000

# Com variáveis de ambiente
API_KEY=secret uvicorn src.main:app --reload
```

### Django

```bash
# Servidor desenvolvimento
python manage.py runserver

# Shell interativo
python manage.py shell

# Migrações
python manage.py migrate
python manage.py makemigrations
```

### Flask

```bash
# Desenvolvimento
flask run --debug

# Com variáveis
FLASK_APP=src.main flask run --debug
```

## 3. Debugging

### PDB (Built-in)

```python
import pdb

def problematic_function():
    pdb.set_trace()  # Breakpoint
    # variáveis disponíveis: l (list), n (next), s (step), c (continue), p (print)
```

```bash
python -m pdb script.py
```

### icecream (Print melhorado)

```bash
pip install icecream
```

```python
from icecream import ic

def calculate(x):
    ic(x * 2)
    return x * 2
```

### Rich + Debug

```bash
pip install rich
```

```python
from rich.console import Console
from rich.traceback import install

console = Console()
install()

console.print("[bold red]Erro![/bold red]")
```

### VS Code

```json
{
  "python.defaultInterpreterPath": ".venv/bin/python",
  "python.linting.enabled": true,
  "python.formatting.provider": "black",
  "python.testing.pytestEnabled": true,
  "python.testing.pytestArgs": ["tests"]
}
```

## 4. Testes

### Executar Testes

```bash
# Todos os testes
pytest

# Com cobertura
pytest --cov=src --cov-report=html

# Testes específicos
pytest tests/test_main.py::test_function

# Testes em watch mode
ptw  # pytest-watch
pytest --watch

# Verbose
pytest -v -vv
```

### Tipos de Testes

```python
# tests/test_api.py
import pytest
from httpx import AsyncClient
from src.main import app

@pytest.fixture
def anyio_backend():
    return "asyncio"

@pytest.mark.asyncio
async def test_root():
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/")
        assert response.status_code == 200
        assert response.json() == {"message": "Hello World"}

 Mocking
from unittest.mock import patch,# Mock

@patch("src.module.function")
def test_with_mock(mock_func):
    mock_func.return_value = "mocked"
    # ...
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
```

## 5. Linting e Formatação

### Ruff (Linting + Formatting)

```bash
# Checar erros
ruff check .

# Corrigir automaticamente
ruff check . --fix

# Formatar
ruff format .
```

### MyPy (Type Checking)

```bash
# Verificar tipos
mypy .

# Com config
mypy --strict .

# Relatório
mypy --html-report report.html
```

### Pre-commit

```bash
# Rodar todos os hooks
pre-commit run --all-files

# Apenas um hook
pre-commit run ruff --all-files
```

## 6. Database

### SQLAlchemy

```python
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, DeclarativeBase

class Base(DeclarativeBase):
    pass

engine = create_engine("sqlite:///app.db")
Session = sessionmaker(bind=engine)

def get_db():
    db = Session()
    try:
        yield db
    finally:
        db.close()
```

### Alembic (Migrations)

```bash
# Inicializar
alembic init migrations

# Criar migration
alembic revision --autogenerate -m "add column"

# Aplicar
alembic upgrade head

# Rollback
alembic downgrade -1
```

### DBeaver / TablePlus

GUI para visualizar banco de dados.

## 7. Build e Deploy

### Build

```bash
# wheel
pip wheel . -w dist/

# Usando hatch
hatch build
```

### Docker

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "src/main.py"]
```

### Poetry

```bash
poetry build
poetry publish
```

## 8. Comandos Úteis

```bash
# Verificar versão
python --version

# Listar pacotes
pip list
pip freeze

# Verificar segurança
pip audit

# Atualizar dependências
pip-tools
pip-compile requirements.in
```

## Checklist de Qualidade

- [ ] Testes passando (`pytest`)
- [ ] Linting limpo (`ruff check`)
- [ ] Tipos corretos (`mypy`)
- [ ] Pre-commit passando
- [ ] Documentação atualizada
- [ ] Commits organizados
