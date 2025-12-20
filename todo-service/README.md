## Структура проекта

```
.
├── app/
│   ├── main.py        # FastAPI-приложение и роуты
│   ├── db.py          # Работа с SQLite
│   └── schemas.py     # Pydantic-схемы
├── Dockerfile
├── requirements.txt
└── README.md
```

---

## Переменные окружения

| Переменная | Описание              | Значение по умолчанию |
| ---------- | --------------------- | --------------------- |
| DATA_DIR   | Директория для данных | `/app/data`           |
| DB_PATH    | Путь к SQLite БД      | `/app/data/todo.db`   |

---

## Запуск через Docker

### 1. Собрать Docker-образ

```bash
docker build -t todo-service:local .
```

---

### 2. Создать volume для хранения данных

```bash
docker volume create todo_data
```

---

### 3. Запустить контейнер

```bash
docker run --rm \
  -p 8000:80 \
  -v todo_data:/app/data \
  --name todo-service \
  todo-service:local
```

После запуска сервис будет доступен по адресу:

* API: [http://localhost:8000](http://localhost:8000)
---

## API эндпоинты

### Создать задачу

`POST /items`

```json
{
  "title": "something",
  "description": "something"
}
```

---

### Получить все задачи

`GET /items`

---

### Получить задачу по ID

`GET /items/{id}`

---

### Обновить задачу

`PUT /items/{id}`

```json
{
  "title": "something",
  "completed": true
}
```

---

### Удалить задачу

`DELETE /items/{id}`

---

## Хранение данных

* Используется SQLite
* Файл базы данных создаётся автоматически при старте
* Данные сохраняются в Docker volume (`todo_data`)

---

## Остановка сервиса

Сочетание клавиш `Ctrl+C`. Контейнер будет остановлен и удалён (`--rm`), а данные сохранятся в volume.

---
