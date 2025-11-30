#!/bin/bash

read -p "Введите путь к директории для архивации: " dirpath

if [ ! -d "$dirpath" ]; then
    echo "Директория не найдена!"
    exit 1
fi

dirname=$(basename "$dirpath")

current_date=$(date +%Y-%m-%d)

archive_name="${dirname}_${current_date}.tar.gz"

tar -czf "$archive_name" -C "$(dirname "$dirpath")" "$dirname"

echo "Архив создан: $archive_name"
