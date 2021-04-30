echo "********************************************************************************************"
echo "* This script stops the Greenplum Database.                                                *"
echo "********************************************************************************************"
echo
export MASTER_DATA_DIRECTORY="/gpdata/master/gpseg-1"
source /usr/local/greenplum-db/greenplum_path.sh
source /usr/local/greenplum-text/greenplum-text_path.sh
echo
echo "********************************************************************************************"
echo "* Stopping GPText (and Zookeeper) on Pivotal Greenplum Database                            *"
echo "********************************************************************************************"
echo
gptext-stop --force
zkManager stop --force
echo "********************************************************************************************"
echo "* Stopping Greenplum Database..."
echo "********************************************************************************************"
echo
gpstop -M immediate -a
echo "* Greenplum Database Stopped.                                                              *"
echo "********************************************************************************************"
echo "* ALL DATABASE RELATED SERVICES STOPPED.    RUN ./start_all.sh to restart                  *"
echo "********************************************************************************************"
echo;
