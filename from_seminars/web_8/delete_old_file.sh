#!/bin/bash

read -p "Введите путь к директории: " dirpath

if [ ! -d "$dirpath" ]; then
    echo "Директория не найдена!"
    exit 1
fi

find "$dirpath" -type f -mtime +7 -exec rm -f {} \;

echo "Все файлы старше 7 дней в директории '$dirpath' удалены."
