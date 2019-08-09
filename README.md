#Routing Scheduling

### Requirements

* ActiveRecord
* Sqlite3
* Ruby version 2.3+

### Run

To execute the application, type this on a terminal
```
$ ruby main.rb
```

### Data

To populate the db, the application loads the data extracting it from the following files
All files should start ##### and separate from every new element with #####
* drivers.txt
** should contain at least 5 text line, if no vehicle is assigned just leave the line blank "" o " "
* routes.txt
** should contain at least 8 text line, if no vehicle and/or no driver is assigned just leave the line blank "" o " "
* vehicles.txt
** should contain at least 3 text line, if no driver is assigned just leave the line blank "" o " "

### Assumptions

* Every city is in the same region
* Just manage data from 1 day ahead
