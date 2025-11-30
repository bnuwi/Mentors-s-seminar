#!/bin/bash

cmd1="sleep 3"
cmd2="sleep 5"
cmd3="sleep 2"

echo "Запускаем команды параллельно..."

$cmd1 &
pid1=$!
$cmd2 &
pid2=$!
$cmd3 &
pid3=$!

echo "PID запущенных команд: $pid1, $pid2, $pid3"

wait $pid1
wait $pid2
wait $pid3

echo "Все команды завершены."
