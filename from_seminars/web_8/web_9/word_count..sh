#!/bin/bash

read -p "Введите имя файла: " filename

if [ ! -f "$filename" ]; then
    echo "Файл не найден!"
    exit 1
fi

read -p "Введите слово для поиска: " word

count=$(grep -o -w "$word" "$filename" | wc -l)

echo "Слово '$word' встречается в файле '$filename' $count раз(а)."
