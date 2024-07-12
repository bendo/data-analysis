# Preparing data

## Adjusting CSV file

- to cut unnecesary data from csv file  
 `cut -d, -f 1,2,3,4,5 all_month.csv > earthquakes.csv`
- to get rid of the first row  
 `tail -n +2 earthquakes.csv > e.tmp`
- check file and rename it  
 `mv e.tmp earthquakes.csv`

## Import CSV file to SQLite DB

- create DB  
 `sqlite3 data.db`
- create table  
 `CREATE TABLE earthquakes (timestamp TEXT, latitude FLOAT, longitude FLOAT, depth FLOAT, mag FLOAT);`
- switch to csv mode  
 `.mode csv`
- import csv file  
 `.import earthquake.csv earthquake`