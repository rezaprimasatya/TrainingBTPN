Setup the proper path for sql in path if "mysqlimport not found error" by adding path of `MySQL Server` in Environment Varaible in windows or bashrc in linux.

Thea we have to turn on local variable to True as it will by default be set to False
On mysql terminal write - 

```
Show Variables Like 'local_infile';
Set Global local_infile = 1;
```

on terminal/command prompt write -
```
mysqlimport --ignore-lines=1 \
            --fields-terminated-by=, \
            --local -u root \
            -p Database \
             TableName.csv
```
`or`

```
mysqlimport  --ignore-lines=1 --fields-terminated-by=,
--columns='ID,Name,Phone,Address' --local -u root -p
Database /path/to/csvfile/TableName.csv 
```

Ignore-lines skips the first line “Some Large Database.” 

The –fields-terminated by tell the utility that the commas separate the columns. 

The –columns is used to map the order of the data in the csv file to the SQL database table. 

–local means that it’s pulling from the local filesystem of the client(your machine). If the file were on the server that it’s being run on then it wouldn’t need that flag. 

The Database is the name of the database in which your table is stored. 
We must put the absolute path of the csv file for it to register with the utility. 
The “TableName.csv” has to match the name of the table in your mysql database.
