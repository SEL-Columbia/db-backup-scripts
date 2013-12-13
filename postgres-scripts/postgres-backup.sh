#/bin/sh

today=`date +%Y-%m-%d`

backup_dest="/home/motech/db-backups/postgres/$today"

rm -rf $backup_dest
rm "$backup_dest.tar"
rm "$backup_dest.tar.gz"

echo "Created a directory $backup_dest"

mkdir -p $backup_dest 

echo "Taking postgres data dump"

pg_dump -h localhost -U postgres drishti > $backup_dest/pg_dump

echo "Archiving the backupfiles"

cd $backup_dest/..

tar -cf "$today.tar" $today

gzip "$today.tar"

rm -rf $backup_dest

echo "Done archiving $backup_dest directory"
