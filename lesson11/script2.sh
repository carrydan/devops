#!/bin/bash

# ��������� ���������� ������ ��� ��������� ������� ���������
export LANG=ru_RU.UTF-8

# ���������
MYFOLDER=~/myfolder
FILE2=$MYFOLDER/file2.txt

# ��������� ������������� ����� myfolder
if [ ! -d "$MYFOLDER" ]; then
    echo "����� $MYFOLDER �� ����������"
    exit 0
fi

# ���������� ���������� ������ � ����� myfolder
file_count=$(find "$MYFOLDER" -type f | wc -l)
echo "���������� ������ � $MYFOLDER: $file_count"

# ���������� ����� ������� ������� ����� � 777 �� 664, ���� ���� ����������
if [ -f "$FILE2" ]; then
    chmod 664 "$FILE2"
fi

# ���������� ������ ����� � ������� ��
find "$MYFOLDER" -type f -empty -delete

# ������� ��� ������ ����� ������ � ��������� ������
for file in "$MYFOLDER"/*; do
    if [ -f "$file" ] && [ -s "$file" ]; then
        sed -i '1!d' "$file"
    fi
done

# ���������� �������� ��� ��������
exit 0