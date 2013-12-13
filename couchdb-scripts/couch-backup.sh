#!/bin/sh

today=`date +%Y-%m-%d`

parent_dir="/home/motech/db-backups"
backup_dest="$parent_dir/couchdb-$today"

rm -rf $parent_dir/couchdb*

echo "Created a directory $backup_dest"
mkdir -p $backup_dest/conf $backup_dest/logs $backup_dest/data

echo "Copying CouchDB configuration files"

cp -rp /etc/couchdb $backup_dest/conf

echo "Copying CouchDB Log files"

cp -rp /var/log/couchdb $backup_dest/logs

echo "Copying CouchDB Database files"

cp -rp /var/lib/couchdb $backup_dest/data

echo "Archiving the backupfiles"

cd $backup_dest/..

tar -cf "couchdb-$today.tar" "couchdb-$today"

gzip "couchdb-$today.tar"

rm -rf $backup_dest

echo "Done archiving $backup_dest directory"
