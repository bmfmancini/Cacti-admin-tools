### This script runs routine health checks for Cacti
#### !!!!!Very Beta not ready for prod yet !!!!!! ######





########Settings ########

cacti_cli_location="/var/www/html/cacti/cli"
sendmail_email=""
cacti_log_location="/var/www/html/cacti/log/cacti.log"
cacti_db_name=""
mysql_username=""
cacti_db_name=""
mysql_log_location="/var/log/mariadb/mariadb.log"
spine_location=""
spine_check_on="no"
check_db_on="no"

#######End of Settings #########

echo "Starting checks"


if  [ "$check_db_on" == "yes" ]
then

echo ***********Database Level checks 

echo "Running an Audit of the Cacti database"
audit_cacti_db="$(php $cacti_cli_location/audit_database.php --report)"
echo "running an analysis of the cacti database"
analyze_cacti_db="$(php $cacti_cli_location/analyze_database.php -d)"

echo "You will be asked for you mysql password "
mysqlcheck -u $mysql_username -p  $cacti_db_name

grep error mysql_log_location
grep "too many" mysql_log_location

printf "%s\n" "$analyze_cacti_db" "$audit_cacti_db"

###########End of DB level check section #######
else

echo "!!!!!!!Database checks will be skipped per settings if you wish for the database to be checked change check_db_on to yes!!!!"
sleep 3
fi



echo  !!!!!!!!!!Cacti Error log analysis !!!!!!!!!!

echo "checking for poller errors in the log"
grep exceeded $cacti_log_location

########End of Cacti error log analysis ######


echo !!!!!!!!!! Check critical proccess state !!!!!!!!!!
printf "HTTPD State\n" 
systemctl status httpd | grep active
printf "Mariadb State\n"
systemctl status mariadb | grep active
printf "Cron daemon state\n"
systemctl status crond | grep active 
printf "%s\n"
####### end Check critical proccess state #####


echo !!!!!!!!!!System Info !!!!!!!!!!

echo !!!!! current free Memory !!!!!
printf "%s\n" 
 free -h
printf "%s\n" 
echo !!!!! PHP version !!!!!
 php -v
printf "%s\n" 
echo !!!!! disk usage !!!!!

 df -h
printf "%s\n" 
echo !!!!!  server uptime !!!!!

 uptime
printf "%s\n" 
######## End of system info ######












