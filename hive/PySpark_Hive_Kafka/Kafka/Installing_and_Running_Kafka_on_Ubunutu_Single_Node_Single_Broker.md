## Installing and Running Kafka on Ubunutu Single Node Single Broker

#### 1. Install JAVA
```
 sudo apt-get update
 sudo apt-get install openjdk-8-jdk
```


#### 2. Download Kafka and Zookeeper
Apache ZooKeeper is an open source service built to coordinate and synchronize configuration information of nodes that belong to a distributed system. A Kafka cluster depends on ZooKeeper to perform—among other things—operations such as detecting failed nodes and electing leaders.
- From Kakfa - https://archive.apache.org/dist/kafka/0.9.0.0/
  - Download link https://archive.apache.org/dist/kafka/0.9.0.0/kafka_2.11-0.9.0.0.tgz/

- From Zookeeper - https://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/
  - Download link https://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/

if these download links are not working choose different links

In the Ubuntu Terminal 
```
	cd/Downloads
	wget https://archive.apache.org/dist/kafka/0.9.0.0/kafka_2.11-0.9.0.0.tgz
```
this will download kafka in download directory
```
	wget https://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz
```
this will download zookeeper in download directory

Checking in the directory for both files
```
	ls
```
Let’s move both files to opt directory in root folder
```
	sudo mv zookeeper-3.4.6.tar.gz /opt
	sudo mv kafka_2.11-0.9.0.0.tgz /opt
```
Let’s unzip the files, first go to opt directory
```
	cd /opt
```
to check the files in opt directory
```
	ls
```
unzip now
```
	sudo tar -zxf kafka_2.11-0.9.0.0.tgz
	sudo tar -zxf zookeeper-3.4.6.tar.gz
```
we need to run the kafka commands here, so remember this location -> cd /opt/kafka_2.11-0.9.0.0/

#### 3. Starting Zookeeper
Now go to zookeeper directory
```
	cd /opt/zookeeper-3.4.6
```
make a data directory inside
```
	sudo  mkdir data
```
Open the editor 
```
	sudo nano conf/zoo_sample.cfg
```
and add the lines:
```
tickTime=2000
dataDir=/opt/zookeeper-3.4.6/data
clientPort=2181
initLimit=5
syncLimit=2
```
Save the file
```CTRL+X -> Y```

After this process is complete, ZooKeeper will be started as a daemon automatically. By default, it will listen on port 2181.
To make sure that it is working, connect to it via Telnet:
```
 telnet localhost 2181
```
At the Telnet prompt, type in 
```
 ruok
```
and press ENTER. If everything's fine, ZooKeeper will say ```imok``` and end the Telnet session.

To start zookeeper do this in *1st terminal*
```
	cd /opt/cd kafka_2.11-0.9.0.0
```
Then we will see /opt/kafka.version$ 
```
	bin/zookeeper-server-start.sh config/zookeeper.properties
```
This should start zookeeper service

If there is an error, we need to see if zookeeper is running or not, open a new terminal and check
```
	sudo lsof -i :2181
```
if some other application the 2181 port we will kill that application by writing its PID numer
```
	sudo kill -9 PID_number
```
then start zookeeper server
```
	bin/zookeeper-server-start.sh config/zookeeper.properties
```


#### 4. Starting Kakfa Server
The next step is to configure the Kakfa server. 
```
 sudo nano /opt/kafka_2.11-0.9.0.0/config/server.properties
```
By default, Kafka doesn't allow you to delete topics. To be able to delete topics, add the following line at the end of the file:
```
delete.topic.enable = true
```
Since Kafka uses Zookeeper, we need to first start a Zookeeper server. We can use the convenience script packaged with Kafka to start a single-node Zookeeper instance or we can start Zookeeper on a standalone instance and specify its configurations in zookeeper.properties configuration file, we would be starting it using the convenience script that is packaged with Kafka. 

To start kafka do this in *2nd terminal*
```
	cd /opt/kafka_2.11-0.9.0.0
```
Then we will see /opt/kafka.version$
```
	bin/kafka-server-start.sh config/server.properties
```

#### 5. To create kafka topic do this in *3rd terminal*
```
	cd /opt/kafka_2.11-0.9.0.0

	bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1   --partitions 1 --topic Hello-Kafka
```
To start broker do this
```
	bin/kafka-console-producer.sh --broker-list localhost:9092 --topic Hello-Kafka
```

#### 6. To start kafka consumer do this in *4th terminal*
```
	cd /opt/kafka_2.11-0.9.0.0

	bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic Hello-Kafka -- whitelist Hello-Kafka
```
#### 7. To start sending messages from producer to consumer
Type a message in producer terminal(3rd terminal) and the message will come to consumer terminal(4th terminal).

Try making more consumers with same command in new terminals
```
	bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic Hello-Kafka -- whitelist Hello-Kafka
```
We will be seeing the message published to all consumers
