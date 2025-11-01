#!/bin/bash

echo "Список файлов и их тип:"
for item in *; do
    if [ -d "$item" ]; then
        echo "$item — каталог"
    elif [ -f "$item" ]; then
        echo "$item — файл"
    elif [ -L "$item" ]; then
        echo "$item — символическая ссылка"
    else
        echo "$item — другой тип"
    fi
done

echo "Имя и права доступа для каждого файла:"
for file in *; do
    perms=$(ls -ld "$file" | awk '{print $1}')
    echo "$file — $perms"
done

if [ -z "$1" ]; then
    echo "Ошибка: не указан аргумент (имя файла для проверки)."
    exit 1
fi

if [ -e "$1" ]; then
    echo "Файл '$1' существует."
else
    echo "Файл '$1' не найден."
fi
