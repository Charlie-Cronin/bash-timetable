# bash-timetable
A bash project that can be used to display a college timetable through the terminal 

primarily made to be run inside the .bashrc file


## How to install 
download the timetable file to the folder you would like to keep it, then run 
```bash
  sudo chmod +x timetable.sh
```
this changes the file permissions to be executable 

The file is also dependant on python and jq being installed on the machine, if these are not preinstalled on your distrobution, please run the following command or your package managers equivalent
```bash
  sudo apt install jq
```
```bash
  sudo apt install python
```

## How to use 

the file should be run in the format 
```bash
  ./timetable.sh start_time end_time start_day end_day path
```
where the start time and end time are in 24 hour clock, the start_day and end_day are the day index starting with monday as 0
and the path is the path to the json file either locally on the disk or as a http reference 

example usages:
``` bash
  ./timetable.sh 9 18 0 4  https://your-domain.com/timetable.json
```
``` bash
  ./timetable.sh 9 18 0 4  ~/Downloads/timetable.json
```

## JSON Formatting 
The json file will be formatted in the form 
``` json
  {
      "WEEKDAY_INDEX":{
          "TIME":{
              "class":"CLASS_NAME",
              "room":"ROOM_NUMBER",
              "type":"CLASS TYPE"
          },
          "TIME":{
              "class":"CLASS_NAME",
              "room":"ROOM_NUMBER",
              "type":"CLASS TYPE"
          },
          ...
      },
      "WEEKDAY_INDEX":{
          "TIME":{
              "class":"CLASS_NAME",
              "room":"ROOM_NUMBER",
              "type":"CLASS TYPE"
          },
          ...
      }
  }
```
where weekday_index is the index of the day of the week, starting with monday at 0
time is the time of the class in the 24 hour clock 
class_name is the name of the class you have 
room_number is the class room number where you do your class 
and type is the class type (tutorial, lecture, lab, etc)

a sample for a monday is listed below 

```json
  {
      "0":{
          "9":{
              "class":"Maths",
              "room":"A123",
              "type":"lecture"
          },
          "10":{
              "class":"Coding",
              "room":"B234",
              "type":"lecture"
          },
          "11":{
              "class":"Linux Admin",
              "room":"C134",
              "type":"lab"
          },
          "12":{
              "class":"Linux Admin",
              "room":"C134",
              "type":"lab"
          },
          "1":{
              "class":"lunch",
              "room":"",
              "type":""
          },
          "2":{
              "class":"Cyber Security",
              "room":"D231",
              "type":"lecture"
          },
          "3":{
              "class":"Cyber Secrutiy",
              "room":"E254",
              "type":"lecture"
          },
          "4":{
              "class":"Maths",
              "room":"F123",
              "type":"tutorial"
          },
          "5":{
              "class":"",
              "room":"",
              "type":""
          },
          "6":{
              "class":"",
              "room":"",
              "type":""
          }
      }
  }
```
