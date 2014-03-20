##DB Backup Scripts (Scripts for backing up drishti databases)
===============================================================

###Description

This repository has the backup scripts for CouchDB, Postgres and MongoDB

  * This script takes one argument as an input, which can be used as password for encryption. 
  The backup files are archived using tar command. Click here to know more about [tar](http://www.computerhope.com/unix/utar.htm).
  * Then, it is being compressed and encrypted using [gzip](http://www.computerhope.com/unix/utar.htm). [Gzip](http://www.computerhope.com/unix/utar.htm) provides the option of specifying the algorithm for encryption. It encrypts using the password that is being passed as the argument while running the script.

###Installation

gpg to be installed to run these scripts. Use command: `brew install gpg`

###CouchDB backup script
**How to run?**

Run the script using the command `sh couchdb-scripts/couch-backup.sh password`, where password is an argument passed.

**Source files**

The script takes the backup of data, logs and configuration from the locations */var/lib/couchdb, /var/log/couchdb and /etc/couchdb* respectively.

**Generated files**

It generates a backup file in the location */home/motech/db-backups/* and the file's format would be couchdb-YYYY-MM-dd.tar.zip. e.g., couchdb-2014-03-20.tar.zip

**For restoring the backup**

Firstly, we need to decompress and decrypt the generated backup file. It can be done using the following command 

  `echo <password> | gpg --batch --no-tty --yes --passphrase-fd 0 -o <output_file> --decrypt <encrypted_file>`

e.g., echo password | gpg --batch --no-tty --yes --passphrase-fd 0 -o couchdb-2014-03-20.tar --decrypt couchdb-2014-03-20.tar.zip

Then, we need to extract from the archive using the command:

`tar -xvf couchdb-2014-03-20.tar`

Finally, copy the required folders to their respective places. e.g., conf can be restored by replacing /etc/couchdb by conf/couchdb.

###Postgres backup script

**How to run?**

Run the script using the command `sh postgres-scripts/postgres-backup.sh password`, where password is an argument passed.

**Source files**

The script takes the dump of postgres of *drishti* database for the user *postres*.

**Generated files**

It generates a backup file in the location */home/motech/db-backups/* and the file's format would be postgres-YYYY-MM-dd.tar.zip. e.g., postgres-2014-03-20.tar.zip

**For restoring the backup**

After decompressing and extracting from the archive (follow the instructions as specified for couchDB restore), use the following command to restore the postgres with the dump,

`psql drishti < dump_file`

###MongoDB backup script

**How to run?**

Run the script using the command `sh mongodb-scripts/mongo-backup.sh password`, where password is an argument passed.

**Source files**

The script takes the dump of mongoDB of *bamboo_dev* database.

**Generated files**

It generates a backup file in the location */home/dristhi/db-backups* and the file's format would be mongodb-YYYY-MM-dd.tar.zip. e.g., mongodb-2014-03-20.tar.zip

**For restoring the backup**

After decompressing and extracting from the archive (follow the instructions as specified for couchDB restore), use the following command to restore the mongoDB with the *bamboo_dev* database dump,

`mongorestore --dbpath dump_file_with_path --db bamboo_dev dump/bamboo_dev`
