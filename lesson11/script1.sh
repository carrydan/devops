#!/bin/bash

# Установим корректную локаль для поддержки русской кодировки
export LANG=ru_RU.UTF-8

# Константы
MYFOLDER=~/myfolder
FILE1=$MYFOLDER/file1.txt
FILE2=$MYFOLDER/file2.txt
FILE3=$MYFOLDER/file3.txt
FILE4=$MYFOLDER/file4.txt
FILE5=$MYFOLDER/file5.txt

# Создаем папку myfolder в домашней директории пользователя, если она не существует
mkdir -p "$MYFOLDER"

# Создаем файл 1 с приветствием и текущей датой/временем
# Если файл уже существует, перезаписываем его
echo -e "Привет!\n$(date)" > "$FILE1"

# Создаем пустой файл 2 с правами 777, если он не существует
if [ ! -f "$FILE2" ]; then
    touch "$FILE2"
    chmod 777 "$FILE2"
fi

# Создаем файл 3 с одной строкой из 20 случайных символов
# Если файл уже существует, перезаписываем его
head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20 > "$FILE3"

# Создаем пустые файлы 4 и 5, если они не существуют
touch "$FILE4" "$FILE5"

# Возвращаем успешный код возврата
exit 0
