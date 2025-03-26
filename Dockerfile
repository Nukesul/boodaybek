# Используем официальный образ Python
FROM python:3.11-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем requirements.txt и устанавливаем зависимости
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь проект
COPY . .

# Собираем статические файлы (если нужно)
RUN python manage.py collectstatic --noinput

# Указываем порт
EXPOSE 8000

# Команда для запуска приложения
CMD ["gunicorn", "backend.wsgi:application", "--bind", "0.0.0.0:8000"]