echo "********************************************************************************************"
echo "* This script stops the Greenplum Database.                                                *"
echo "********************************************************************************************"
echo "* Stopping Greenplum Database..."
source /usr/local/greenplum-db/greenplum_path.sh
export MASTER_DATA_DIRECTORY="/gpdata/master/gpseg-1"
gpstop -M immediate -a
echo "* Greenplum Database Stopped.                                                              *"
echo "********************************************************************************************"
echo "* ALL DATABASE RELATED SERVICES STOPPED.    RUN ./start_all.sh to restart                  *"
echo "********************************************************************************************"
echo;
