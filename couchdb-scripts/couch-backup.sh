#!/bin/sh

today=`date +%Y-%m-%d`

parent_dir="/home/motech/db-backups"
backup_dest="$parent_dir/couchdb-$today"

rm -rf $parent_dir/couchdb*

echo "Created a directory $backup_dest"
mkdir -p $backup_dest

echo "Archiving the backup files"

cd $backup_dest

echo "Archiving CouchDB configuration files"

tar -Pczf "couchdb-config.$today.tar" "/etc/couchdb"

echo "Archiving CouchDB Log files"

tar -Pczf "couchdb-log.$today.tar" "/var/log/couchdb"

echo "Archiving CouchDB Database files"

tar -Pczf "couchdb-data.$today.tar" "/var/lib/couchdb"

cd $backup_dest/..

echo "Archiving Everything"

tar -czf "couchdb-$today.tar" "$backup_dest"

echo "Zipping and Encrypting the backup files"

echo $1 | gpg  --batch --no-tty --yes --passphrase-fd 0 -o "couchdb-$today.tar.zip" --cipher-algo aes256 --compress-algo zip --symmetric "couchdb-$today.tar"

rm -rf "couchdb-$today.tar" 
rm -rf "$backup_dest"

echo "Done archiving $backup_dest directory"