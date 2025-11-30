#!/bin/bash

read -p "Введите адрес удалённого сервера (user@host): " REMOTE_SERVER
read -p "Введите порог нагрузки CPU (например, 2.0): " CPU_THRESHOLD
read -p "Введите имя или часть имени процесса для завершения при перегрузке: " PROCESS_NAME

LOAD=$(ssh "$REMOTE_SERVER" "uptime" | awk -F 'load average: ' '{print $2}' | awk -F',' '{print $1}')

echo "Средняя загрузка CPU на сервере $REMOTE_SERVER: $LOAD"

EXCEEDS=$(echo "$LOAD > $CPU_THRESHOLD" | bc)

if [ "$EXCEEDS" -eq 1 ]; then
    echo "Нагрузка выше порога ($CPU_THRESHOLD)! Завершаем процессы с именем '$PROCESS_NAME'..."
    
    ssh "$REMOTE_SERVER" bash -c "'
        pids=\$(pgrep -f \"$PROCESS_NAME\")
        if [ -n \"\$pids\" ]; then
            echo \"Найдены процессы для завершения: \$pids\"
            kill -9 \$pids
        else
            echo \"Процессы с именем \"$PROCESS_NAME\" не найдены.\"
        fi
    '"
else
    echo "Нагрузка в норме."
fi
