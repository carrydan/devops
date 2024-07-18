#!/bin/bash

export LANG=ru_RU.UTF-8

mkdir -p ~/myfolder

echo -e "Привет!\n$(date)" > ~/myfolder/file1.txt

if [ ! -f ~/myfolder/file2.txt ]; then
    touch ~/myfolder/file2.txt
    chmod 777 ~/myfolder/file2.txt
fi

head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20 > ~/myfolder/file3.txt

touch ~/myfolder/file4.txt ~/myfolder/file5.txt
