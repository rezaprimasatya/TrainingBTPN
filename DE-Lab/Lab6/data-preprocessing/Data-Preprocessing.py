
# coding: utf-8

# # Data Preprocessing

# In[1]:


# Import Python libraries
import pandas as pd # pandas can read and manage datasets


# ### Import the Dataset - Data is given in .csv format, make sure the file is part of the root directory, along with this file.

# #### Different ways to print the dataset
# 1. print(dataset) # prints raw data, no table.
# 2. dataset.head() # prints the first 5 columns, or can take a number as a parameter to print n number of cloumns.
# 3. dataset # print with variable which will display in an organized table format.

# In[2]:


# Importing the dataset
dataset = pd.read_csv('Data.csv') # we use pandas to read csv
dataset # prints everything in the dataset


# Note: the country (index 0) and purchased (index 3) columns are known as category values. Each column contains similar values. Index 0 has three categories: France, Spain and Germany, and index 3 has two catgeories: yes and no. 

# In[3]:


x = dataset.iloc[:, :-1].values # the colon (:) means selection of all indexs (columns)
print(x) # prints every column but the last index 3 (Purchased Column)


# In[4]:


y = dataset.iloc[:, 3].values
print(y) # prints only the last column index 3 (Purchased Column)


# ## Dealing with missing datasets

# In[5]:


# Now lets take care of missing data (NaN)
# Import Scikit-Learn
# Imputer is a class of sklearn
from sklearn.preprocessing import Imputer # a machine modeling library with Imputer that takes care of missing data
imputer = Imputer(missing_values = 'NaN', strategy = 'mean', axis = 0) # since there is a value missing, we use statistics to find the mean value and fill in the gap.
imputer = imputer.fit(x[:, 1:3]) # print index columns 1 and 2 only. Note: we assume that we will place 2 instead of 3, but we need to take in consideration the lower bounds. Therefore, in this case 3 is correct.
x[:, 1:3] = imputer.transform(x[:, 1:3])
print(x) # print x values


# As you can see from the values from above, the average age of 38.777..8 (index 1 - column 2) replaces the missing NaN value, and the average salary of $63,777.777..8 (index 2 - column3) replaces the NaN value.
# 
# Note:depending on the dataset, the mean may not always be the rigth approach, with sklearn we can also find the median and the most frequent value along the axis of the dataset.   

# ## Categorical Data

# In[6]:


# Encoding categorical data
from sklearn.preprocessing import LabelEncoder
labelencoder_x = LabelEncoder()
labelencoder_x.fit_transform(x[:,0]) # transforms each category into an integer value


# In[7]:


# Encoding categorical data
from sklearn.preprocessing import LabelEncoder
labelencoder_x = LabelEncoder()
x[:,0] = labelencoder_x.fit_transform(x[:,0]) # code changed here
print(x) # calling x this time replaces each string category with its respective integer value


# France = 0; Spain = 1; Germany = 2;
# However, since its an integer value, python will assume that Germany (2) is bigger than Spain (1) and Spain is bigger than France (0). Bugs can come out of this, therefore, we add dummy varibales where each catgeory will have its own column, and each integer value will be displayed in each column that corresponds to index 0

# In[8]:


# Encoding categorical data with OneHotEncoder
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelencoder_x = LabelEncoder()
x[:,0] = labelencoder_x.fit_transform(x[:,0]) 
onehotencoder = OneHotEncoder(categorical_features = [0])
x = onehotencoder.fit_transform(x).toarray()
print(x) # call x varibale


# In[9]:


# Display purchase column category
labelencoder_y = LabelEncoder()
y = labelencoder_y.fit_transform(y)
print(y) # call y, prints index 3 - last column


# # Spliting the Dataset

# In[10]:


# Spliting the dataset into the Training set and Test set
from sklearn.model_selection import train_test_split 
# the training and testing features of the matrice of x and y
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size = 0.2, random_state = 0) # 20% of dataset  


# In[11]:


# Output dataset into test and training 
print(x_train)


# In[12]:


print(x_test)


# In[13]:


print(y_train)


# In[14]:


print(y_test)


# # Feature Scaling
# Scaling the page column and salary column.

# In[15]:


from sklearn.preprocessing import StandardScaler
sc_x = StandardScaler()
x_train = sc_x.fit_transform(x_train)
x_test = sc_x.transform(x_test)
print(x_train) # ignore the -1 and 1 values


# In[16]:


print(x_test)

