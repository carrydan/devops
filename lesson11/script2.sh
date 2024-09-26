#!/bin/bash

# Установим корректную локаль для поддержки русской кодировки
export LANG=ru_RU.UTF-8

# Константы
MYFOLDER=~/myfolder
FILE2=$MYFOLDER/file2.txt

# Проверяем существование папки myfolder
if [ ! -d "$MYFOLDER" ]; then
    echo "Папка $MYFOLDER не существует"
    exit 0
fi

# Определяем количество файлов в папке myfolder
file_count=$(find "$MYFOLDER" -type f | wc -l)
echo "Количество файлов в $MYFOLDER: $file_count"

# Исправляем права доступа второго файла с 777 на 664, если файл существует
if [ -f "$FILE2" ]; then
    chmod 664 "$FILE2"
fi

# Определяем пустые файлы и удаляем их
find "$MYFOLDER" -type f -empty -delete

# Удаляем все строки кроме первой в остальных файлах
for file in "$MYFOLDER"/*; do
    if [ -f "$file" ] && [ -s "$file" ]; then
        sed -i '1!d' "$file"
    fi
done

# Возвращаем успешный код возврата
exit 0