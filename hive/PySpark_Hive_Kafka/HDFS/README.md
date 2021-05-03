# HDFS_commands
___
### List Files

* list Command

``hdfs dfs -ls /``
List all the files/directories for the given hdfs destination path.

``hdfs dfs -ls -d /hadoop ``
Directories are listed as plain files.

``hdfs dfs -ls -h /data``
Format file sizes in a human-readable fashion.

``hdfs dfs -ls -R /data``
Recursively list all files In hadoop directory and all subdirectories in hadoop directory. 

``hdfs dfs -ls /hadoop/dat*``
List all the files matching the pattern. In this case, it will list all the files inside hadoop directory which starts with 'dat'. 

* count Command

``hdfs dfs -count hdfs:/``
Count the number of directories, files and bytes under the paths that match the specified file pattern.

___
### Read/Write Files

* text Command

``hdfs dfs -text /hadoop/test``
HDFS Command that takes a source file and outputs the file in text format.

* cat Command

``hdfs dfs -cat /hadoop/test``
HDFS Command that copies source paths to stdout.

* appendToFile command

``hdfs dfs appendToFile /home/ubuntu/test1 /hadoop/test2``
Appends the content of a local file test1 to a hdfs file test2. 

* tail Command

``hdfs dfs -tail /hadoop/new``
Displays last kilobyte of the file "new" to stdout

* getmerge Command

``hdfs dfs -getmerge /hadoop/new test``
Takes a source directory and a destination file as input and concatenates files in src into the destination local file.
___
### Upload/Download Files

* put Command

``hdfs dfs -put /home/ubuntu/sample /hadoop``
Copies files from local file system to HDFS

``hdfs dfs -put -f /home/ubuntu/sample /hadoop``
Copies files from local file system to HDFS, and in case the local already exits in the given destination path, using -f option with put command will overwrite it. 

``hdfs dfs -put -l /home/ubuntu/sample /hadoop``
Copies files from local file system to HDFS. Allow DataNode to lazily persist the file to disk. Forces replication factor of 1.

``hdfs dfs -put -p /home/ubuntu/sample /hadoop``
Copies files from local file system to HDFS. Passing -p preserves access and modification times, ownership and the mode. 

* get Command

``hdfs dfs -get /newfile /home/ubuntu/``
HDFS Command to copy files from hdfs to the local file system.

``hdfs dfs -get -p /newfile /home/ubuntu/``
HDFS Command to copy files from hdfs to the local file system. Passing -p preserves access and modification times, ownership and the mode. 

``hdfs dfs -get -p /hadoop/*.txt /home/ubuntu/``
Copies all the files matching the pattern from HDFS to local file system.

* copyFromLocal Command

``hdfs dfs -copyFromLocal /home/ubuntu/new /hadoop``
HDFS Command to copy the file from Local file system to HDFS.

* copyToLocal Command

``hdfs dfs -copyToLocal /hadoop/sample /home/ubuntu/``
Similar to get command, except that the destination is restricted to a local file reference.

* moveFromLocal Command

``hdfs dfs -moveFromLocal /home/ubuntu/new /hadoop``
HDFS Command to copy the file from Local file system to HDFS, similar to put command, except the source is deleted after it's copied.

* distcp Command

``hdfs dfs -distcp hdfs://namenodeA/apache_hadoop hdfs://namenodeB/hadoop``
Copy a directory from one node in the cluster to another
___
### File Management

* mv Command

``hdfs dfs -mv /hadoop/sample /tmp``
HDFS Command to move files from source to destination. This command allows multiple sources as well, in which case the destination needs to be a directory.

* cp Command

``hdfs dfs -cp -p /hadoop/file1 /hadoop1``
HDFS Command to copy files from source to destination. This command allows multiple sources as well, in which case the destination must be a directory.

``hdfs dfs -cp -f /hadoop/file1 /hadoop1``
Passing -f overwrites the destination if it already exists.

* rm Command

``hdfs dfs -rm /hadoop/file1``
HDFS Command to remove the file from HDFS.

``hdfs dfs -rm -r /hadoop/hello``

``hdfs dfs -rm -R /hadoop/hello``

``hdfs dfs -rmr /hadoop/hello``
HDFS Command to remove the entire directory and all of its content from HDFS.

``hdfs dfs -rm -skipTrash /hadoop/hello``
Bypass trash and delete specified file(s) immediately.

``hdfs dfs -rm -f /hadoop/hello``
If file does not exist, do not display a diagnostic message or modify the exit satus to reflect an error.

* rmdir Command

``hdfs dfs -rmdir /hadoop/hello``
Delete a directory

* mkdir Command

``hdfs dfs -mkdir /hadoop``
HDFS Command to create the directory in HDFS.

* touchz Command

``hdfs dfs -touchz /hadoop/sample``
HDFS Command to create a file in HDFS with file size 0 bytes.

* expunge Command

``hdfs dfs -expunge``
HDFS Command that makes the trash empty.
___
### Ownership and Validation

* checksum Command

``hdfs dfs -checksum /hadoop/file1``
Returns the checksum information of a file.

* chmod Command

``hdfs dfs -chmod 777 /hadoop/file1``
Change the permissions of files.

``hdfs dfs -chmod -R 777 /hadoop``
Change the permissions of files recursively.

* chown Command

``hdfs dfs -chown ubuntu:ubuntu /hadoop``
HDFS command to change the owner of files. First ubuntu in command is the owner and second ubuntu is group.

``hdfs dfs -chown -R ubuntu:ubuntu /hadoop``
HDFS command to change the owner of files recursively.

* chgrp Command

``hdfs dfs -chgrp ubuntu /hadoop``
Changes the group associated with the file.

``hdfs dfs -chgrp -R ubuntu /hadoop``
Changes the group associated with the files recursively.
___
### File System

* df Command 

``hdfs dfs -df /hadoop``
Displays capacity, free space and used space at given hdfs destination.

``hdfs dfs -df -h /hadoop``
Displays capacity, free space and used space at given hdfs destination in human-readable fashion.

* du Command

``hdfs dfs -du /hadoop/file``
Displays size of files and directories contained in the given directory or the size of a file if its just a file.

``hdfs dfs -du -s /hadoop/file``
Displays a summary of file lengths.

``hdfs dfs -du -h /hadoop/file``
Formats size in human-readable format.
___
### Administration


* balancer Command

``hdfs balancer``
Run a cluster balancing utility. Percentage of disk capacity.

* Version Check

``hadoop version``
To check the version of Hadoop.

* fsck Command

``hdfs fsck /``
HDFS Command to check the health of the Hadoop file system.

* dfsadmin Command

``hdfs dfsadmin -safemode leave``
To turn-off safemode of NameNode

``hdfs dfsadmin -refreshNodes``
Re-read the hosts and exclude files to update the set of Datanodes that are allowed to connect to the NameNode and those that should be decommissioned or recommissioned.

* namenode -format Command

``hdfs namenode -format``
Formats the NameNode.

* setrep Command

``hdfs dfs -setrep -w 2 /usr/sample``
Default replication factor to a file is 3. Below HDFS command is used to change replication factor of a file.

* stat Command

``hdfs dfs -stat "%F %u:%g %b %y %n" /hadoop/test``
Print statistics about the file/directory at <path> in the specified format. Format accepts filesize in blocks (%b), type (%F), group name of owner (%g), name (%n), block size (%o), replication (%r), user name of owner(%u), and modification date (%y, %Y). %y shows UTC date as “yyyy-MM-dd HH:mm:ss” and %Y shows milliseconds since January 1, 1970 UTC. If the format is not specified, %y is used by default.

* getfacl Command

``hdfs dfs -getfacl /hadoop``
Displays the Access Control Lists (ACLs) of files and directories. If a directory has a default ACL, then getfacl also displays the default ACL.
___
