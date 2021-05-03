ResultScanner rScanner = null;  
 
    try {  
 
      table = conn.getTable(tableName);  
 
      Scan scan = new Scan();  
      scan.addColumn(Bytes.toBytes("info"), Bytes.toBytes("name"));  
      // Set the filter criteria.  
      SingleColumnValueFilter filter = new SingleColumnValueFilter(  
          Bytes.toBytes("info"), Bytes.toBytes("name"), CompareOp.EQUAL,  
          Bytes.toBytes("Xu Bing"));  
      scan.setFilter(filter);  
      // Submit a scan request.  
      rScanner = table.getScanner(scan);  
      // Print query results.  
      for (Result r = rScanner.next(); r != null; r = rScanner.next()) {  
        for (Cell cell : r.rawCells()) {  
          LOG.info(Bytes.toString(CellUtil.cloneRow(cell)) + ":"  
              + Bytes.toString(CellUtil.cloneFamily(cell)) + ","  
              + Bytes.toString(CellUtil.cloneQualifier(cell)) + ","  
              + Bytes.toString(CellUtil.cloneValue(cell)));  
        }  
      }  
      LOG.info("Single column value filter successfully.");  
    } catch (IOException e) {  
      LOG.error("Single column value filter failed " ,e);  
    } finally {  
        if (rScanner != null) {   
            // Close the scanner object.  
            rScanner.close();  
          }  
      if (table != null) {  
        try {  
          // Close the HTable object.  
          table.close();  
        } catch (IOException e) {  
          LOG.error("Close table failed " ,e);  
        }  
      }  
    }  
    LOG.info("Exiting testSingleColumnValueFilter.");  
  }

