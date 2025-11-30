#!/bin/bash

read -p "Введите длину пароля: " length

if ! [[ "$length" =~ ^[0-9]+$ ]]; then
    echo "Ошибка: введите числовое значение!"
    exit 1
fi

password=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c "$length")

echo "Сгенерированный пароль: $password"
