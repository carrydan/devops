#!/bin/bash
export LANG=ru_RU.UTF-8
if [ ! -d ~/myfolder ]; then
    echo "Папка ~/myfolder не существует"
    exit 0
fi

file_count=$(ls ~/myfolder | wc -l)
echo "Количество файлов в ~/myfolder: $file_count"

if [ -f ~/myfolder/file2.txt ]; then
    chmod 664 ~/myfolder/file2.txt
fi

find ~/myfolder -type f -empty -delete

for file in ~/myfolder/*; do
    if [ -f "$file" ] && [ -s "$file" ]; then
        sed -i '1!d' "$file"
    fi
done