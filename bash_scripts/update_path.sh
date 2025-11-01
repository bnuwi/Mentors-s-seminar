#!/bin/bash

if [ -z "$1" ]; then
    echo "Ошибка: укажите директорию, которую нужно добавить в PATH."
    echo "Пример: ./update_path.sh /home/$USER/scripts"
    echo "Текущее значение PATH:"
    echo "$PATH"
    exit 1
fi

NEW_DIR="$1"

export PATH="$PATH:$NEW_DIR"

echo "Новое значение PATH (временно, до закрытия терминала):"
echo "$PATH"

read -p "Хотите сохранить эту директорию в PATH навсегда? [y/n]: " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    if grep -q "$NEW_DIR" ~/.bashrc; then
        echo "Директория уже есть в ~/.bashrc, добавление не требуется."
    else
        echo "Добавление пути в ~/.bashrc..."
        echo "export PATH=\"\$PATH:$NEW_DIR\"" >> ~/.bashrc
        echo "Изменения сохранены в ~/.bashrc"
        echo "Чтобы применить их сейчас, выполните:"
        echo "source ~/.bashrc"
    fi
else
    echo "Изменения не сохранены в ~/.bashrc."
fi