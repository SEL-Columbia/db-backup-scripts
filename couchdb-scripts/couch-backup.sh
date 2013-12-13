#!/bin/sh

today=`date +%Y-%m-%d`

backup_dest="/home/motech/db-backups/couch/$today"

rm -rf $backup_dest
rm "$backup_dest.tar"
rm "$backup_dest.tar.gz"

echo "Created a directory $backup_dest"
mkdir -p $backup_dest $backup_dest/conf $backup_dest/logs $backup_dest/data

echo "Copying CouchDB configuration files"

cp -rp /etc/couchdb $backup_dest/conf

echo "Copying CouchDB Log files"

cp -rp /var/log/couchdb $backup_dest/logs

echo "Copying CouchDB Database files"

cp -rp /var/lib/couchdb $backup_dest/data

echo "Archiving the backupfiles"

cd $backup_dest/..

tar -cf "$today.tar" $today

gzip "$today.tar"

rm -rf $backup_dest

echo "Done archiving $backup_dest directory"
