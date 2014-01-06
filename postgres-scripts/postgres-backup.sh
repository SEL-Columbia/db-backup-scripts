#/bin/sh

today=`date +%Y-%m-%d`

parent_dir="/home/motech/db-backups"
backup_dest="$parent_dir/postgres-$today"

rm -rf $parent_dir/postgres*

echo "Created a directory $backup_dest"

mkdir -p $backup_dest 

echo "Taking postgres data dump"

pg_dump -h localhost -U postgres drishti > $backup_dest/pg_dump

echo "Archiving the backup files"

cd $backup_dest/..

tar -cf "postgres-$today.tar" "postgres-$today"

echo "Zipping and Encrypting the backup files"

echo $1 | gpg  --batch --no-tty --yes --passphrase-fd 0 -o "postgres-$today.tar.zip" --cipher-algo aes256 --compress-algo zip --symmetric "postgres-$today.tar"

rm -rf $backup_dest

rm -rf "postgres-$today.tar"

echo "Done archiving $backup_dest directory"
