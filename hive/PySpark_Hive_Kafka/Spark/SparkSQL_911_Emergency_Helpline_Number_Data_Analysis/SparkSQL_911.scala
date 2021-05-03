// parse the data into a dataframe
val ehl = sc.textFile("911.csv")

// remove the header from the dataset
val header = ehl.first()
val ehl1 = ehl.filter(row => row != header)

// declaring a case class with the schema of our dataset
case class emergency(lat:String, lng:String, desc:String, zip:String, title:String, timeStamp:String, twp:String, addr:String, e:String)
val emergency_data = ehl1.map(x => x.split(",")).filter(x => x.length>=9).map(x => emergency(x(0), x(1), x(2), x(3), x(4).substring(0 , x(4).indexOf(":")),x(5),x(6),x(7),x(8))).toDF

// registering the data in a table
emergency_data.registerTempTable("emergency_911")

// same steps for Zipcodes data
val ehl2 = sc.textFile("zipcode.csv")

val header1 = ehl2.first()

val ehl3 = ehl2.filter(row => row != header1)

case class zipcode(zip:String, city:String, state:String, latitude:String, longitude:String, timezone:String, dst:String)
val zipcodes = ehl3.map(x => x.split(",")).map(x=> zipcode(x(0).replace("\"", ""), x(1).replace("\"", ""), x(2).replace("\"", ""), x(3), x(4), x(5), x(6))).toDF

zipcodes.registerTempTable("zipcode_table")

// joining both datasets by taking the required columns
// joining the datasets by keeping the key as zipcode, to get the city and the state from where the calls are coming
val build1 = sqlContext.sql("select e.title, z.city,z.state from emergency_911 e join zipcode_table z on e.zip = z.zip")

// kind of problems that are prevalent in states
val ps = build1.map(x => (x(0)+" -->"+x(2).toString))
val ps1 = ps.map(x=> (x,1)).reduceByKey(_+_).map(item => item.swap).sortByKey(false).foreach(println)

val ps = build1.map(x => (x(0)+" -->"+x(1).toString))
val ps1 = ps.map(x=> (x,1)).reduceByKey(_+_).map(item => item.swap).sortByKey(false).foreach(println)
