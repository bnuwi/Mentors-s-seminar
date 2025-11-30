#!/bin/bash

read -p "Введите адрес удалённого сервера (user@host): " REMOTE_SERVER
read -p "Введите порог свободного места в процентах (например, 20): " THRESHOLD
read -p "Введите email для уведомлений: " EMAIL

USAGE=$(ssh "$REMOTE_SERVER" "df / | awk 'NR==2 {print \$5}' | sed 's/%//'")

echo "Использование диска на сервере $REMOTE_SERVER: $USAGE%"

if [ "$USAGE" -gt $((100 - THRESHOLD)) ]; then
    echo "Свободное место меньше $THRESHOLD%! Отправка уведомления на $EMAIL..."
    echo "Внимание! На сервере $REMOTE_SERVER заканчивается место на диске. Использование: $USAGE%" \
        | mail -s "Предупреждение: место на диске на $REMOTE_SERVER" "$EMAIL"
else
    echo "Свободного места достаточно."
fi
