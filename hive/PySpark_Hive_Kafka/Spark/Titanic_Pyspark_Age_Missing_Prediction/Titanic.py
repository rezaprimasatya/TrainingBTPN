df = spark.read.option("header", "true").csv("s3://galvanize22/titanic.csv")


df.printSchema()

df.show(4)

df.count()

df.describe().show()

df.select("age", "survived").show(4)

df.groupby("survived").count().show()

df.groupby("age", "survived").count().show()

# check missing values in all columns
from pyspark.sql.functions import col
print(df.where(col("age").isNull()).count())
print(df.where(col("pclass").isNull()).count())
print(df.where(col("survived").isNull()).count())
print(df.where(col("embarked").isNull()).count())
print(df.where(col("sex").isNull()).count())

df.describe('age').show()

print(df.count(), len(df.columns))

df = df.withColumn("AGEImputed", (df["age"] * 0))

df.show(20)

df = df.withColumnRenamed("row.names", "rows")

imputed = df.select("rows", "AGEImputed").fillna(1)  # making a new dataframe with filling missing values in AGEImputed, also including rows column so we can merge this to original df

imputed_e = df.select("rows", "embarked").fillna('Southampton')

df = df.drop("AGEImputed", "embarked")  # so we have a new imputed dataframe with 1 and 0 for age missing, let's drop the AGEImputed column from df
df.show(4)

df.columns, imputed.columns, imputed_e.columns

titanic = df.join(imputed, ['rows'])  # merging df and imputed on rows column and saving in titanic
titanic = titanic.join(imputed_e, ['rows'])
titanic.show(20)

# check missing values in all columns
print(titanic.where(col("age").isNull()).count())
print(titanic.where(col("pclass").isNull()).count())
print(titanic.where(col("survived").isNull()).count())
print(titanic.where(col("embarked").isNull()).count())
print(titanic.where(col("sex").isNull()).count())

# now we can select the rows, name, ticket, boat, room, home.dest columns from titanic, and change age dataype from string to float
titanic = titanic.select('pclass', 'survived', 'embarked', 'sex', 'AGEImputed', titanic.age.cast('float'))

test = titanic.filter(col("AGEImputed") == 1)  # dataframe for which we have missing age
train = titanic.filter(col("AGEImputed") == 0)  # dataframe for which we have age values

# now we can drop the AGEImputed column from both these dataframes
# test = test.drop("AGEImputed")
# train = train.drop("AGEImputed")

test.columns, train.columns

print("Number of training records: " + str(train.count()))
print("Number of testing records : " + str(test.count()))

# one-hot encoding  'pclass', 'embarked', 'sex'
from pyspark.ml.feature import OneHotEncoder, StringIndexer, IndexToString, VectorAssembler
from pyspark.ml.regression import RandomForestRegressor
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
from pyspark.ml import Pipeline, Model

x = StringIndexer(inputCol = "pclass", outputCol = "pclass_1").fit(train).transform(train)
OneHotEncoder(inputCol = "pclass_1", outputCol = "pclass_2").transform(x).show(10)   # demonstrating the work of OneHotEncoder with StringIndexer

si_pclass = StringIndexer(inputCol = "pclass", outputCol = "pclass_1")
si_embarked = StringIndexer(inputCol = "embarked", outputCol = "embarked_1")
si_survived = StringIndexer(inputCol = "survived", outputCol = "survived_1")
si_sex = StringIndexer(inputCol = "sex", outputCol = "sex_1")

vectorAssembler_features = VectorAssembler(inputCols = ["pclass_1", "embarked_1", "sex_1", "survived_1"], outputCol = "features")

rf = RandomForestRegressor(labelCol = "age", featuresCol = "features")

pipeline_rf = Pipeline(stages = [si_pclass, si_embarked, si_survived, si_sex, vectorAssembler_features, rf])

train.printSchema()

pipeline_rf.fit(train)