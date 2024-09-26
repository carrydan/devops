#!/bin/bash
timestamp=$(date +\%F-\%H-\%M)
backup_dir="/opt/mysql_backup"
mysqldump -u root carrydan > $backup_dir/carrydan-$timestamp.sql
