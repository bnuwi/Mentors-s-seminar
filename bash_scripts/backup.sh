#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Укажите путь к директории для копирования"
    exit 1
fi

SOURCE_DIR="$1"

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Директория '$SOURCE_DIR' не найдена!"
    exit 1
fi

DATE=$(date +%Y%m%d)

BACKUP_DIR="./backup_$DATE"
mkdir -p "$BACKUP_DIR"

LOG_FILE="./backup_$DATE.log"
COUNT=0

for file in "$SOURCE_DIR"/*; do
    if [[ -f "$file" ]]; then
        BASENAME=$(basename "$file")
        cp "$file" "$BACKUP_DIR/${BASENAME}_$DATE"
        echo "Скопирован $file -> $BACKUP_DIR/${BASENAME}_$DATE" >> "$LOG_FILE"
        ((COUNT++))
    fi
done

echo "Резервное копирование завершено. Всего файлов: $COUNT"
echo "Лог сохранен в $LOG_FILE"
