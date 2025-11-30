#!/bin/bash

read -p "Введите путь к директории: " dirpath

if [ ! -d "$dirpath" ]; then
    echo "Директория не найдена!"
    exit 1
fi

cd "$dirpath" || exit 1

for file in *; do
    if [ -f "$file" ]; then
        mv "$file" "backup_$file"
    fi
done

echo "Префикс 'backup_' добавлен ко всем файлам в директории '$dirpath'."
