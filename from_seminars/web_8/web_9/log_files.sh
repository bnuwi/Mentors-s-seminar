#!/bin/bash

read -p "Введите путь к директории: " dirpath

if [ ! -d "$dirpath" ]; then
    echo "Директория не найдена!"
    exit 1
fi

find "$dirpath" -type f -name "*.log" -printf "%T@ %p\n" | sort -n | head -n 5 | awk '{print $2}'
