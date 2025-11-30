#!/bin/bash

read -p "Введите путь к директории: " dirpath

if [ ! -d "$dirpath" ]; then
    echo "Директория не найдена!"
    exit 1
fi

cd "$dirpath" || exit 1

for file in *; do
    if [ -f "$file" ]; then
        lower_file=$(echo "$file" | tr 'A-Z' 'a-z')
        if [ "$file" != "$lower_file" ]; then
            mv "$file" "$lower_file"
        fi
    fi
done

echo "Все имена файлов в директории '$dirpath' преобразованы в строчные буквы."
