#!/bin/sh
if [ $# -eq 0 ]; then
	echo "No backup directory provided"
	exit 1
fi
BACKUP_DIR=$1
if [ ! -d "$BACKUP_DIR" ]; then
	echo "$BACKUP_DIR is not a directory"
	exit 1
fi

PREFIX="wikilabels"
DAY_OF_WEEK="$(date +%A)"
TIMESTAMP="$(date +%Y-%m-%d)"

OLD_FILES="$BACKUP_DIR/$PREFIX.$DAY_OF_WEEK.*.gz"
COMPRESSED_FILE="$BACKUP_DIR/$PREFIX.$DAY_OF_WEEK.$TIMESTAMP.gz"

#echo $DAY_OF_WEEK
#echo $TIMESTAMP

# Make dump
pg_dump dbname | gzip -c > "$COMPRESSED_FILE"

# Clear out old dump file
rm -rf $OLD_FILES

echo "New daily backup $COMPRESSED_FILE"
