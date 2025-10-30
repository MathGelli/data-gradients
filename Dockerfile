FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# libs comuns p/ CV (evita erros do OpenCV)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential git gcc \
    libgl1 libglib2.0-0 \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# deps pinadas primeiro (cache eficiente)
COPY requirements.txt /app/requirements.txt
RUN python -m pip install --upgrade pip && pip install -r /app/requirements.txt

# código do projeto
COPY . /app

# padrão: rodar a suíte de testes
CMD ["pytest", "-q"]
