FROM python:3.11-slim

# 禁止產出.pyc編譯檔
ENV PYTHONDONTWRITEBYTECODE=1
# Log即使輸出(stdout / stderr 不經緩衝，立刻輸出)g
ENV PYTHONUNBUFFERED=1

WORKDIR .

COPY requirements.txt .

RUN pip install --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

COPY . .

RUN python manage.py collectstatic --noinput

EXPOSE 8080

CMD ["gunicorn", "-w", "1", "-b", "0.0.0.0:8080", "core.wsgi:application"]