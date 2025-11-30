#!/bin/bash

read -p "Введите адрес удалённого сервера (user@host): " REMOTE_SERVER
read -p "Введите путь к директории на удалённом сервере для архивирования: " REMOTE_DIR
read -p "Введите локальный путь для сохранения архива: " LOCAL_DIR

if [ ! -d "$LOCAL_DIR" ]; then
    echo "Локальная директория не найдена, создаём..."
    mkdir -p "$LOCAL_DIR"
fi

DIR_NAME=$(basename "$REMOTE_DIR")
CURRENT_DATE=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVE_NAME="${DIR_NAME}_backup_${CURRENT_DATE}.tar.gz"

echo "Создаём архив $ARCHIVE_NAME на удалённом сервере..."
ssh "$REMOTE_SERVER" "tar -czf /tmp/$ARCHIVE_NAME -C $(dirname "$REMOTE_DIR") $DIR_NAME"


echo "Скачиваем архив на локальный компьютер..."
scp "$REMOTE_SERVER:/tmp/$ARCHIVE_NAME" "$LOCAL_DIR/"


echo "Разархивируем файл $ARCHIVE_NAME в $LOCAL_DIR..."
tar -xzf "$LOCAL_DIR/$ARCHIVE_NAME" -C "$LOCAL_DIR"


ssh "$REMOTE_SERVER" "rm -f /tmp/$ARCHIVE_NAME"

echo "Операция завершена. Директория разархивирована в $LOCAL_DIR."
