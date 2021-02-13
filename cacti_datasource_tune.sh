#!/bin/bash

##Author Sean Mancini
#www.seanmancini.com
#Version 1.0

##Purpose this script will facilitate the installation of Cacti along with all supporting binaries 
#this script will also ensure that proper configurations are put in place to get up and running with cacti

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





echo  "enter data source name"
read -r ds_name

ls -l /var/www/html/cacti/rra/ | grep $ds_name  | awk '{print $9}' > fix_datasource_list
check_lines="$(cat fix_datasource_list | wc -l)"

if [[ $check_lines == 0 ]]
then
 echo "No matches found !!!"
  exit 0
   else

echo "Enter new Minimum Value"
  read -r min_value

echo "Enter new Maximum Value"
  read -r max_value





### Display current DS setup
current_ds_settings="$(cat fix_datasource_list | head -1)"


echo "the current Datasource configuration per the RRD is"
 rrdinfo /var/www/html/cacti/rra/$current_ds_settings | grep .m
  echo " "
   echo " "

echo "The following files will be edited"
 cat fix_datasource_list

echo " "
 echo " "

echo "The following command will be executed on these RRA files"
echo "/usr/bin/rrdtool tune /var/www/html/cacti/rra/<rrd file name> --minimum $ds_name:$min_value"
echo "/usr/bin/rrdtool tune /var/www/html/cacti/rra/<rrd file name> --maximum $ds_name:$max_value"


echo "Would you like to proceed ? enter 1 for yes 2 for no"
 read -r proceed

if [[ $proceed == "1" ]]
 then


while read p; do

 /usr/bin/rrdtool tune /var/www/html/cacti/rra/$p --minimum $ds_name:$min_value
/usr/bin/rrdtool tune /var/www/html/cacti/rra/$p --maximum $ds_name:$max_value


if [[ $heartbeat_value = " " ]]
then
echo "hello"
fi

echo $p;

done < fix_datasource_list

else

echo "Operation cancelled no changes have been made"
fi
 fi
