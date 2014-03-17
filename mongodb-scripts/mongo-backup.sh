#!/bin/bash

today=`date +%Y-%m-%d`

parent_dir="/home/motech/db-backups"
backup_dest="$parent_dir/mongodb-$today"
MONGO_DB="bamboo_dev"
rm -rf $parent_dir/mongodb*

echo "Created a directory $backup_dest"
mkdir -p $backup_dest

echo "Dumping MongoDB data to backup files"

mongodump --db $MONGO_DB --out  $backup_dest

echo "Archiving the backup files"

cd $parent_dir

tar -cf "mongodb-$today.tar" "mongodb-$today"

echo "Zipping and Encrypting the backup files"

echo $1 | gpg  --batch --no-tty --yes --passphrase-fd 0 -o "mongodb-$today.tar.zip" --cipher-algo aes256 --compress-algo zip --symmetric "mongodb-$today.tar"

rm -rf $backup_dest

rm -rf "mongodb-$today.tar"

echo "Done archiving $backup_dest directory"