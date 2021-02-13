#!/bin/bash

##Author Sean Mancini
#www.seanmancini.com
#Version 1.0


##Dont forget to checkout cacti @ www.cacti.net

#    This program is free software: you can redistribute it and/or modify#
#    it under the terms of the GNU General Public License as published by#
#    the Free Software Foundation, either version 3 of the License, or#
#    (at your option) any later version.#
#    This program is distributed in the hope that it will be useful,#
#    but WITHOUT ANY WARRANTY; without even the implied warranty of#
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the#
#    GNU General Public License for more details.#
#    You should have received a copy of the GNU General Public License#
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.#



mode=$1


if [[ $mode = "" ]]
then
echo "Please select an option see -h "
exit 0
fi


if [[ $mode = "--h" || $mode = "--H"  ]]
then
echo "This script will reindex devices that the Cacti log"
echo "Show need to be reindex there are a few options to do the reindex"
echo "-h Prints this menu"
echo "--file allows you to input a file with all of the device ID's to be reindexed 1 per line"
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
