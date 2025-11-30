#!/bin/bash

read -p "Введите путь к файлу: " filepath

if [ -f "$filepath" ]; then
    echo "Файл найден!"
else
    echo "Файл не найден."
fi
