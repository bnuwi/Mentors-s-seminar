#!/bin/bash

echo "Загрузка процессора:"
uptime
echo ""

echo "Использование памяти:"
free -h
echo ""

echo "Использование диска:"
df -h
echo ""

MEM_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

if (( MEM_USAGE > 80 )); then
    echo "Беда беда, использование памяти превышает 80% ($MEM_USAGE%)"
    echo "Топ процессов по потреблению памяти:"
    ps aux --sort=-%mem | head -n 10
else
    echo "Все в норме, всего $MEM_USAGE%, выдыхай"
fi
