sudo systemctl restart network
echo "*********************************************************************************"
echo "* Script starts the Greenplum DB                                                *"
echo "*********************************************************************************"
echo "* Starting Greenplum Database...                                                *"
source /usr/local/greenplum-db/greenplum_path.sh
source /usr/local/greenplum-text/greenplum-text_path.sh
export MASTER_DATA_DIRECTORY="/gpdata/master/gpseg-1"
gpstart -a
echo "*********************************************************************************"
echo "* Pivotal Greenplum Database Started on port 5432                               *"
echo "*********************************************************************************"
echo
echo "*********************************************************************************"
echo "* Starting GPText (and Zookeeper) on Pivotal Greenplum Database                 *"
echo "*********************************************************************************"
zkManager start
gptext-start
echo
echo
psql -d gpadmin -t -c "SELECT version();"
psql -d gpadmin -t -c "SELECT madlib.version();"
psql -d gpadmin -t -c "SELECT gptext.version();"
