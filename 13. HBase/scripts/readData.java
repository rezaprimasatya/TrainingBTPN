public void testGet() {  
    LOG.info("Entering testGet.");  
    // Specify the column family name.  
    byte[] familyName = Bytes.toBytes("info");  
    // Specify the column name.  
    byte[][] qualifier = { Bytes.toBytes("name"), Bytes.toBytes("address") };  
    // Specify RowKey.  
    byte[] rowKey = Bytes.toBytes("012005000201");  
    Table table = null;  
    try {  
      // Create the Table instance.  
      table = conn.getTable(tableName);  
      // Instantiate a Get object.  
      Get get = new Get(rowKey);  
      // Set the column family name and column name.  
      get.addColumn(familyName, qualifier[0]);  
      get.addColumn(familyName, qualifier[1]);  
      // Submit a get request.  
      Result result = table.get(get);  
      // Print query results.  
      for (Cell cell : result.rawCells()) {  
        LOG.info(Bytes.toString(CellUtil.cloneRow(cell)) + ":"  
            + Bytes.toString(CellUtil.cloneFamily(cell)) + ","  
            + Bytes.toString(CellUtil.cloneQualifier(cell)) + ","  
            + Bytes.toString(CellUtil.cloneValue(cell)));  
      }  
      LOG.info("Get data successfully.");  
    } catch (IOException e) {  
      LOG.error("Get data failed " ,e);  
    } finally {  
      if (table != null) {  
        try {  
          // Close the HTable object.  
          table.close();  
        } catch (IOException e) {  
          LOG.error("Close table failed " ,e);  
        }  
      }  
    }  
    LOG.info("Exiting testGet.");  
}

