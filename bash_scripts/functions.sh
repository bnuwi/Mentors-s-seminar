#!/bin/bash

greet() {
    local name="$1"       
    echo "Hello, $name"
}

sum_numbers() {
    local a="$1"
    local b="$2"
    echo "Сумма $a и $b: $((a + b))"    
}

greet "User"

sum_numbers 3 8