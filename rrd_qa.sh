rrd_path="/var/www/html/cacti/rra/*"
past_min="10"


timestamp=$(date +%s -d $past_min'mins ago');
echo $timestamp

for rrd in $rrd_path;
do

scan=$(rrdtool fetch $rrd LAST -s $timestamp | grep nan | wc -l  )

if [[ $scan >  $past_min ]]
then 
echo $rrd "Dead RRD"
fi


done

