### This script runs routine health checks for Cacti

########Settings ########

cacti_cli_location="/var/www/html/cacti/cli"
sendmail_email=""
cacti_log_location="/var/www/html/cacti/log/cacti.log"
cacti_db_name=""
mysql_username="root"
cacti_db_name="cacti"
#######End of Settings #########




##########Database Level checks ###########

echo "Running an Audit of the Cacti database"
audit_cacti_db="$(php $cacti_cli_location/audit_database.php --report)"
echo "running an analysis of the cacti database"
analyze_cacti_db="$(php $cacti_cli_location/analyze_database.php -d)"
sleep 2

echo "You will be asked for you mysql password "
mysqlcheck -u $mysql_username -p  $cacti_db_name


###########End of DB level check section #######




#########Cacti Error log analysis #########

echo "checking for poller errors in the log"
grep exceeded $cacti_log_location

########End of Cacti error log analysis ######










printf "%s\n" "$analyze_cacti_db" "$audit_cacti_db"



