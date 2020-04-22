#!/bin/bash
for id in "$@"
do
php /var/www/html/cacti/cli/poller_reindex_hosts.php --id=$id --debug
done
