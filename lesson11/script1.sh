#!/bin/bash

# ��������� ���������� ������ ��� ��������� ������� ���������
export LANG=ru_RU.UTF-8

# ���������
MYFOLDER=~/myfolder
FILE1=$MYFOLDER/file1.txt
FILE2=$MYFOLDER/file2.txt
FILE3=$MYFOLDER/file3.txt
FILE4=$MYFOLDER/file4.txt
FILE5=$MYFOLDER/file5.txt

# ������� ����� myfolder � �������� ���������� ������������, ���� ��� �� ����������
mkdir -p "$MYFOLDER"

# ������� ���� 1 � ������������ � ������� �����/��������
# ���� ���� ��� ����������, �������������� ���
echo -e "������!\n$(date)" > "$FILE1"

# ������� ������ ���� 2 � ������� 777, ���� �� �� ����������
if [ ! -f "$FILE2" ]; then
    touch "$FILE2"
    chmod 777 "$FILE2"
fi

# ������� ���� 3 � ����� ������� �� 20 ��������� ��������
# ���� ���� ��� ����������, �������������� ���
head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20 > "$FILE3"

# ������� ������ ����� 4 � 5, ���� ��� �� ����������
touch "$FILE4" "$FILE5"

# ���������� �������� ��� ��������
exit 0
