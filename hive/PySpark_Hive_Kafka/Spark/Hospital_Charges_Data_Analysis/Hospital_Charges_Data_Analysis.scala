val session = org.apache.spark.sql.SparkSession.builder.master("local").appName("Spark CSV Reader").getOrCreate;

// load all the CSV data as a DataFrame into Spark SQL
// inferschema automatically infers the data type of the columns.
val hosp = session.read.format("com.databricks.spark.csv").option("header", "true").option("inferSchema", "true").load("inpatientCharges.csv")

// to see the contents inside the DataFrame
hosp.show  

// save the data in a table by registering it in a temp table
hosp.registerTempTable("hospital_charges")

// amount of Average Covered Charges per state
hosp.groupBy("ProviderState").avg("AverageCoveredCharges").show

// amount of Average Total Payments charges per state
hosp.groupBy("ProviderState").avg("AverageTotalPayments").show

// amount of Average Medicare Payments charges per state
hosp.groupBy("ProviderState").avg("AverageMedicarePayments").show

// total number of Discharges per state and for each disease
hosp.groupBy(("ProviderState"),("DRGDefinition")).sum("TotalDischarges").show
hosp.groupBy(("ProviderState"),("DRGDefinition")).sum("TotalDischarges").sort(desc(sum("TotalDischarges").toString)).show
hosp.groupBy(("ProviderState"),("DRGDefinition")).sum("TotalDischarges").orderBy(desc(sum("TotalDischarges").toString)).show
