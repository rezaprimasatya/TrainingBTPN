public void testCreateTable() { 
    LOG.info("Entering testCreateTable."); 
    // Specify the table descriptor. 
    HTableDescriptor htd = new HTableDescriptor(tableName); (1) 
    // Set the column family name to info. 
    HColumnDescriptor hcd = new HColumnDescriptor("info"); (2) 
    // Set data encoding methods, HBase provides DIFF,FAST_DIFF,PREFIX 
    // and PREFIX_TREE 
    hcd.setDataBlockEncoding(DataBlockEncoding.FAST_DIFF); 
    // Set compression methods, HBase provides two default compression 
    // methods:GZ and SNAPPY 
// GZ has the highest compression rate,but low compression and 
    // decompression effeciency,fit for cold data 
    // SNAPPY has low compression rate, but high compression and 
    // decompression effeciency,fit for hot data. 
    // it is advised to use SNAANPPY 
    hcd.setCompressionType(Compression.Algorithm.SNAPPY);// 
    htd.addFamily(hcd);  (3) 
    Admin admin = null;  
    try { 
    // Instantiate an Admin object. 
    admin = conn.getAdmin();  (4)  
    if (!admin.tableExists(tableName)) { 
        LOG.info("Creating table..."); 
        admin.createTable(htd);//  (5) 
        LOG.info(admin.getClusterStatus()); 
        LOG.info(admin.listNamespaceDescriptors()); 
        LOG.info("Table created successfully."); 
    } else { 
        LOG.warn("table already exists"); 
    } 
    } catch (IOException e) { 
        LOG.error("Create table failed " ,e); 
    } finally { 
    if (admin != null) { 
        try { 
        // Close the Admin object. 
        admin.close(); 
        } catch (IOException e) { 
        LOG.error("Failed to close admin " ,e); 
        } 
    } 
    } 
    LOG.info("Exiting testCreateTable."); 
}    

