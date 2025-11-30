#!/bin/bash

read -p "Введите адрес удалённого сервера (user@host): " REMOTE_SERVER
read -p "Введите email для уведомлений: " EMAIL


ssh "$REMOTE_SERVER" bash -c "'
echo \"Проверка обновлений на сервере $(hostname)...\"

# Обновление списка пакетов и системы (для Debian/Ubuntu)
sudo apt update && sudo apt -y upgrade

# Проверка, требуется ли перезагрузка
if [ -f /var/run/reboot-required ]; then
    echo \"Перезагрузка сервера...\"
    sudo reboot
    exit 0
fi
'"

echo "Обновление на сервере $REMOTE_SERVER завершено." | mail -s "Обновление сервера $REMOTE_SERVER" "$EMAIL"

echo "Скрипт завершён."
