# Используем официальный образ Python
FROM python:3.11-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Устанавливаем зависимости для psycopg2 и других библиотек
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Копируем requirements.txt и устанавливаем зависимости
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь проект
COPY . .

# Указываем метки
LABEL app_id="boodai-pizza"

# Собираем статические файлы (если нужно)
RUN python manage.py collectstatic --noinput

# Указываем порт
EXPOSE 8000

# Команда для запуска приложения
CMD ["gunicorn", "backend.wsgi:application", "--bind", "0.0.0.0:8000"]