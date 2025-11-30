#!/bin/bash

usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$usage" -gt 80 ]; then
    echo "Внимание! Использование диска превышает 80% ($usage%)."
else
    echo "Использование диска в норме ($usage%)."
fi
