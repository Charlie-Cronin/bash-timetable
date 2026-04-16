#!/bin/bash

start_hour=$1
end_hour=$2
start_day=$3
end_day=$4

path=$5


#establish the variables
weekday=$(date +%u)
weekday=$((weekday-1))

hour=$(date +"%I")
hour=$((10#$hour))
minute=$(date +"%M")

#account for if file is local or online 
if [[ $path =~ "http" ]]; then
    json_file=$(curl -s $path | python -m json.tool)
else
    json_file=$(cat $path | python -m json.tool)
fi


function display_timetable(){
    local day_arg=$1
    local hour_arg=$2

    echo " "
    class='Class: ' 
    class="${class} $(echo $json_file | jq -r --arg day "$day_arg" --arg hourKey "$hour_arg" '.[$day][$hourKey].class') - "
    class="${class} $(echo $json_file | jq -r --arg day "$day_arg" --arg hourKey "$hour_arg" '.[$day][$hourKey].type')"
    echo $class

    room='Room: '
    room="${room} $(echo $json_file | jq -r --arg day "$day_arg" --arg hourKey "$hour_arg" '.[$day][$hourKey].room')"
    echo $room
    echo " "
}

if [ $weekday -ge $end_day ]; then 
    #weekend 
    # when its a weekend, display mondays first class 
    display_timetable $start_day $start_hour
    exit;
fi

if [ $(date +"%H") -ge $end_hour ] && [ $weekday -lt $end_day ]; then
    #evening time
    # when its past 6 o clock, display the next days first class 
    display_timetable "$((weekday+1))" $start_hour
    exit;
fi


if [ $(date +"%k") -lt $start_hour ]; then 
    #early morning 
    # when college hasnt started yet, then display toddays first class 
    
    display_timetable "$weekday" $start_hour
    exit;
fi


if [ $minute -ge 40 ]; then 
    #approaching next class
    # when its 20 minutes to the next class, switch from displaying the current class to the next class 
    display_timetable "$weekday" "$((hour+1))"
    exit;
fi

#current class 
# when no other parameters are fufilled, display the current class 
display_timetable "$weekday" "$hour"
