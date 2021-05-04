#!/bin/bash
##########################################################################################################################################
# Install the Oracle JDK 1.8
# Download and Install the Jenkins on the Ubuntu 18.04 64 bit machine 
#
#
#
#
# Author : Tapan Banker , Email tapan@tcloudplus.com 
# Date: Sept 22, 2018
#######################

echo Please enter the log location with file name
### For example /home/ec2-user/setupoutput.txt
read logFilePath

STARTTIMER=$(date +%s)
### ------------------------------------  Ubuntu System Update  
updateUbuntu_Install_Nano () {
	# Update one or all packages on your system 
	sudo apt-get update -y
	sudo echo "Update one or all packages on your system " >> $1 
}


### ------------------------------------  Install Java JDK from Oracle 
install_Oracle_JDK () {	
	cd ~
	# Oracle Java Installation , work from home dir 
	# Download  JDK 1.8 and accept license
	wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz
	mkdir /opt/jdk
	sudo echo "Download  JDK 1.8 and accept license " >> $1 
	# Unzip the file
	tar -zxf jdk-8u181-linux-x64.tar.gz -C /opt/jdk
	ls /opt/jdk
	sudo echo "Java Installation" >> $1 
	# Update altenatives for java and javac
	update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_181/bin/java 100
	update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_181/bin/javac 100
	update-alternatives --display java
	update-alternatives --display javac
	java -version
	sudo echo "Oracle JDK 1.8 Installation completed." >> $1 	
}

### ------------------------------------  Download and Install Jenkins as Service 
install_Jenkins () {	
	cd ~
	sudo echo "download the Jenkins and add the apt-key." >> $1 
	# download the Jenkins and add the apt-key
	wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
	# Perofmr the jenkins list
	sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
	# Update one or all packages on your system 
	sudo apt-get update -y
	# Install Jenins 
	sudo apt-get install jenkins -y
	sudo echo "Jenkins Installation completed." >> $1 	
	sudo echo "--------------- Jenkins Login Password ------ " 
	sleep 5s
	cat /var/lib/jenkins/secrets/initialAdminPassword >> $1 
	sudo echo "-------------------------------------------------------- " 
	# systemctl status jenkins
	# systemctl stop jenkins
	# systemctl start jenkins
	# systemctl restart jenkins
}

 

# Make the call to the function and pass the LogFile Path 
# Make Update in the Ubuntu 
updateUbuntu_Install_Nano $logFilePath
# Install Oracle
install_Oracle_JDK $logFilePath
# Install Jenkins 
install_Jenkins $logFilePath
 

ENDTIMER=$(date +%s)
DIFF=$(( $ENDTIMER - $STARTTIMER ))
sudo echo "Total Time for execution is $DIFF seconds" >> $logFilePath
sudo echo "Total Time for execution is $DIFF seconds"


 