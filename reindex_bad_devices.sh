##Script by Sean Mancini

####This is a quick script that allow you to specify multiple devices that need to be reindex
##when you get a messege in the log like You have 2 Devices with bad SNMP Indexes you can try this script to 
##reindex the devices all you need is the device ID enter like so ./reindex 1 2 3
###


#!/bin/bash
for id in "$@"
do
php /var/www/html/cacti/cli/poller_reindex_hosts.php --id=$id --debug
done
