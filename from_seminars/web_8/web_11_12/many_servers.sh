#!/bin/bash

read -p "Введите путь к файлу со списком серверов: " SERVER_FILE
read -p "Введите команду для выполнения на серверах: " COMMAND
read -p "Введите путь к лог-файлу: " LOG_FILE

if [ ! -f "$SERVER_FILE" ]; then
    echo "Файл со списком серверов не найден!"
    exit 1
fi

> "$LOG_FILE"

while IFS= read -r SERVER; do
    if [ -n "$SERVER" ]; then
        echo "Подключение к серверу $SERVER..." | tee -a "$LOG_FILE"
        echo "-----------------------------" >> "$LOG_FILE"
        ssh "$SERVER" "$COMMAND" >> "$LOG_FILE" 2>&1
        echo "-----------------------------" >> "$LOG_FILE"
        echo "Команда выполнена на сервере $SERVER" | tee -a "$LOG_FILE"
    fi
done < "$SERVER_FILE"

echo "Все команды выполнены. Вывод сохранён в $LOG_FILE."
