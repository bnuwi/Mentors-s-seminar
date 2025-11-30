#!/bin/bash

read -p "Введите команду для запуска в фоне: " cmd

$cmd &

pid=$!

echo "Команда '$cmd' запущена в фоне с PID: $pid"
