FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY app/requirements.txt . 
RUN pip install --no-cache-dir -r requirements.txt

# Копируем все файлы из папки app непосредственно в /app в контейнере
COPY app/ .

RUN useradd -m appuser && chown -R appuser /app
USER appuser

EXPOSE 5000
CMD ["python", "app.py"]
