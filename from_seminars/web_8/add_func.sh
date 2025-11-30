#!/bin/bash

read -p "Введите первое число: " first_arg
read -p "Введите второе число: " second_arg

add() {
    local a=$1
    local b=$2
    local sum=$((a + b))
    echo "Сумма: $sum"
}

add "$first_arg" "$second_arg"
