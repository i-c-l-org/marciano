<!-- AVISO DE PROVENIÊNCIA E AUTORIA -->

> **Proveniência e Autoria**
>
> Este arquivo ou componente faz parte do ecosistema Doutor/Prometheus.
> Distribuído sob os termos de licença MIT-0.
> O uso do material neste componente não implica em apropriação ou violação de direitos autorais, morais ou de terceiros.
> Em caso de problemas com nosso uso, entre em contato pelo email: ossmoralus@gmail.com


# 🦙 Ollama — Modelos de IA Local

## O que é

Ollama permite rodar modelos de linguagem localmente no seu PC, sem enviar dados para a nuvem.

## Instalação

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

> Para atualizar, rode o mesmo comando novamente.

## Verificar instalação

```bash
ollama --version
```

## Gerenciar o serviço

```bash
sudo systemctl start ollama    # inicia
sudo systemctl stop ollama     # para
sudo systemctl restart ollama  # reinicia
systemctl status ollama        # verifica status
```

## Baixar modelos

```bash
# Modelo leve (~4.7GB) — bom para PCs com 8GB RAM
ollama pull qwen2.5-coder:7b

# Modelo melhor (~8.5GB) — recomendado para 16GB+ RAM
ollama pull qwen2.5-coder:14b
```

## Testar modelo

```bash
ollama run qwen2.5-coder:7b "escreva um hello world em Python"
```

## Listar modelos instalados

```bash
ollama list
```

## Limitar uso de CPU/RAM (evitar travamentos)

```bash
sudo systemctl edit ollama
```

Adicione o conteúdo abaixo e salve (`Ctrl+O`, `Enter`, `Ctrl+X`):

```ini
[Service]
Environment="OLLAMA_NUM_PARALLEL=1"
Environment="OLLAMA_MAX_LOADED_MODELS=1"
CPUQuota=60%
MemoryLimit=4G
```

Depois recarregue:

```bash
sudo systemctl daemon-reload
sudo systemctl restart ollama
```

## Interface Web (opcional)

Para usar o Ollama pelo navegador via Open WebUI:

```bash
docker run -d \
  -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  ghcr.io/open-webui/open-webui:main
```

Acesse em: `http://localhost:3000`

## Aviso sobre GPU

Se aparecer `WARNING: No NVIDIA/AMD GPU detected`, o Ollama vai rodar apenas pela CPU. Funciona normalmente, mas é mais lento (~5-15 tokens/segundo no modelo 7b).

