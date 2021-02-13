#!/bin/bash
##Script by Sean Mancini

####This is a quick script that allow you to specify multiple devices that need to be reindex
##when you get a messege in the log like You have 2 Devices with bad SNMP Indexes you can try this script to 




mode=$1


if [[ $mode = "" ]]
then
echo "Please select an option see -h "
exit 0
fi


if [[ $mode = "--h" || $mode = "--H"  ]]
then
echo "This script will reindex devices that the Cacti log"
echo " Show need to be reindex there are a few options to do the reindex"
echo "-h Prints this menu"
echo " --file allows you to input a file with all of the device ID's to be reindexed 1 per line"
echo "--id followed by the device ID will re-index that device only"
fi





if [[ $mode = "--file" ]]
then
echo "Please specify the file with ID's"
read  -r file

## Check if input file is actually there 
if [ ! -f $file ]; then
    echo "File not found!"
    exit 0
fi


while read p;
do
php /var/www/html/cacti/cli/poller_reindex_hosts.php --id=$p --debug
done < $file
fi

if [[ $mode = "--id" ]]
then
for id in "$@"
do
php /var/www/html/cacti/cli/poller_reindex_hosts.php --id=$id --debug
done

fi
