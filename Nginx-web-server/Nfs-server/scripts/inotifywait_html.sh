#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
inotifywait -mrq --timefmt "%F %H:%M:%S" --format "%T %w%f" -e create,delete,close_write  /html \
|while read line
	do
		rsync -az --delete --password-file=/etc/rsync.password /html/ rsync_backup@Backup-server::html
	done
