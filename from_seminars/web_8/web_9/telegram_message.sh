#!/bin/bash

BOT_TOKEN="8464411173:AAGoM_LrLc6O6bv-aZvRZEdTxjC9CaGR4Hg"

CHAT_ID="997372719"

read -p "Введите сообщение для отправки: " MESSAGE

curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d chat_id="$CHAT_ID" \
     -d text="$MESSAGE"

echo "Сообщение отправлено."
