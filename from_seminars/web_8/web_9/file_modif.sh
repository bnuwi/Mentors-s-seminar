#!/bin/bash

read -p "Введите путь к файлу для отслеживания: " filepath

if [ ! -f "$filepath" ]; then
    echo "Файл не найден!"
    exit 1
fi

last_mod=$(stat -c %Y "$filepath")

echo "Отслеживание изменений файла '$filepath'"

while true; do
    sleep 2 
    current_mod=$(stat -c %Y "$filepath")
    if [ "$current_mod" != "$last_mod" ]; then
        echo "Файл '$filepath' был изменён!"
        last_mod=$current_mod
    fi
done
