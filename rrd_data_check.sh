#!/bin/bash

##Author Sean Mancini
#www.seanmancini.com
#Version 1.0


## Purpose This script will check the RRD files in the chosen directory for NAN values indicating
##The RRD file has not recvived any new data either because no input has been pushed to the graph or a permissions issue

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



#!/bin/bash

input=$1

if [[ $1 = "" ]]
then input=--a
echo "No options selected so running in Automation mode see --h for help menu"
fi

if [[ $input = --h ]] || [[ $input = --H ]]
then
echo "--a sets the script to automatic mode which will look at the past 10 minutes of data"
echo "if you would like Automode to default to your rra folder and a specific timeframe update the"
echo "rrd_path and past_min variables"
echo "--i sets the script into interactive mode which allows you to set which path and timeframe"
echo "-h prints this menu"
fi

if [[ $input = --i ]] || [[ $input = --I ]]
then
echo "script in interactive mode"

echo "Enter RRA Path typically /var/www/html/cacti/rra"
read -r rrd_path
echo "How many minutes in the past would you like to fetch data for NAN values"
read -r past_min

fi


if [[ $input = --a ]] || [[ $input = --A ]]
then
rrd_path="/var/www/html/cacti/rra/*"
past_min="10"
fi


timestamp=$(date +%s -d $past_min'mins ago');
echo $timestamp

for rrd in $rrd_path;
do

scan=$(rrdtool fetch $rrd LAST -s $timestamp | grep nan | wc -l  )

if [[ $scan >  $past_min ]]
then 
echo $rrd "Dead RRD" the Last $scan values were NaN
fi


done


