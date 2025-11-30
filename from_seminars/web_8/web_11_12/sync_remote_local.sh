#!/bin/bash

read -p "Введите локальную директорию: " LOCAL_DIR
read -p "Введите адрес удалённого сервера (user@host): " REMOTE_SERVER
read -p "Введите удалённую директорию: " REMOTE_DIR
read -p "Введите email для отчёта: " EMAIL

if [ ! -d "$LOCAL_DIR" ]; then
    echo "Локальная директория не найдена!"
    exit 1
fi

EXCLUDE_FILE=$(mktemp)
echo "*.tmp" >> "$EXCLUDE_FILE"
echo "cache/" >> "$EXCLUDE_FILE"
echo "*.log" >> "$EXCLUDE_FILE"

echo "Синхронизация локальная -> удалённая..."
rsync -avz --exclude-from="$EXCLUDE_FILE" "$LOCAL_DIR/" "$REMOTE_SERVER:$REMOTE_DIR/" > rsync_report_local_to_remote.txt

echo "Синхронизация удалённая -> локальная..."
rsync -avz --exclude-from="$EXCLUDE_FILE" "$REMOTE_SERVER:$REMOTE_DIR/" "$LOCAL_DIR/" > rsync_report_remote_to_local.txt

cat rsync_report_local_to_remote.txt rsync_report_remote_to_local.txt | mail -s "Отчёт синхронизации $LOCAL_DIR <-> $REMOTE_SERVER:$REMOTE_DIR" "$EMAIL"

rm "$EXCLUDE_FILE"

echo "Синхронизация завершена. Отчёт отправлен на $EMAIL."
