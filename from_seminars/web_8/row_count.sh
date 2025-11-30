#!/bin/bash

read -p "Введите имя файла: " filename

if [ ! -f "$filename" ]; then
    echo "Файл не найден!"
    exit 1
fi

line_count=$(wc -l < "$filename")

echo "Количество строк в файле '$filename': $line_count"
