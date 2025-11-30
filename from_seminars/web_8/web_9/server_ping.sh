#!/bin/bash

read -p "Введите адрес сервера или IP: " server

if ping -c 1 -W 2 "$server" &> /dev/null; then
    echo "Сервер $server доступен."
else
    echo "Сервер $server недоступен."
fi
