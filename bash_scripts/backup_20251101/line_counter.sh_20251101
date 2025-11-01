#!/bin/bash

if [[ -f "input.txt" ]]; then
    echo "Файл input.txt найден. Содержимое:"
    cat input.txt
    
    wc -l input.txt > output.txt
    echo -e "\nКоличество строк записано в output.txt"
else
    ls input.txt 2> error.log
    echo "Сообщение об ошибке записано в error.log"
fi