#!/bin/bash

read -p "Введите путь к директории для резервного копирования: " SOURCE_DIR
read -p "Введите адрес удалённого сервера (user@host): " REMOTE_SERVER
read -p "Введите путь на удалённом сервере для хранения архивов: " REMOTE_DIR

DIR_NAME=$(basename "$SOURCE_DIR")
CURRENT_DATE=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVE_NAME="${DIR_NAME}_backup_${CURRENT_DATE}.tar.gz"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Директория '$SOURCE_DIR' не найдена!"
    exit 1
fi

echo "Создаём архив $ARCHIVE_NAME..."
tar -czf "$ARCHIVE_NAME" -C "$(dirname "$SOURCE_DIR")" "$DIR_NAME"


echo "Копирование архива на $REMOTE_SERVER:$REMOTE_DIR..."
scp "$ARCHIVE_NAME" "$REMOTE_SERVER:$REMOTE_DIR"

rm "$ARCHIVE_NAME"

echo "Удаление старых архивов на удалённом сервере..."
ssh "$REMOTE_SERVER" bash -c "'
cd \"$REMOTE_DIR\" || exit
ls -1t | grep \"${DIR_NAME}_backup_.*\.tar\.gz\" | tail -n +4 | xargs -r rm -f
'"

echo "Резервное копирование завершено успешно."
