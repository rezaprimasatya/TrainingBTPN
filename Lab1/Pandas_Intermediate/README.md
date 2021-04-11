[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/rezaprimasatya/TrainingBTPN/blob/Pandas_intermediate/colab)

## Content
The course has the following content:

### Numpy
- [Numpy arrays:](01-DA_Numpy_arrays_creation.ipynb): what they are and how to create, import and save them
- [Maths with Numpy arrays](02-DA_Numpy_array_maths.ipynb): applying functions to arrays, doing basic statistics with arrays
- [Numpy and Matplotlib](03-DA_Numpy_matplotlib.ipynb): Basics of plotting Numpy arrays with Matplotlib
- [Recovering parts of arrays](04-DA_Numpy_indexing.ipynb): Using array coordinates to extract information (indexing, slicing)
- [Combining arrays](05-DA_Numpy_combining_arrays.ipynb): Assembling arrays by concatenation, stacking etc. Combining arrays of different sizes (broadcasting)
  
### Pandas
- [Introduction to Pandas](06-DA_Pandas_introduction.ipynb): What does Pandas offer?
- [Pandas data structures](07-DA_Pandas_structures.ipynb): Series and dataframes
- [Importing data to Pandas](08-DA_Pandas_import_plotting.ipynb): Importing data tables into Pandas (from Excel, CSV) and plotting them
- [Pandas operations](09-DA_Pandas_operations.ipynb): Applying functions to the contents of Pandas dataframes (classical statistics, ```apply``` function etc.)
- [Combining Pandas dataframes](10-DA_Pandas_combine.ipynb): Using concatenation or join operations to combine dataframes
- [Analyzing Pandas dataframes](11-DA_Pandas_splitting.ipynb): Split dataframes into groups (```groupy```) for category-based analysis
- [A real-world example](12-DA_Pandas_realworld.ipynb): Complete pipeline including data import, cleaning, analysis and plotting and showing the nitty-gritty issues one often faces with real data

### Local installation
For a local installation, we recommend using conda to create a specific environment to run the code. If you don't yet have conda, you can e.g. install miniconda, see [here](https://docs.conda.io/en/latest/miniconda.html) for instructions. Then:

1. Clone the repository to your computer using [this link](https://github.com/guiwitz/NumpyPandas_course/archive/master.zip) and unzip it
2. Open a terminal and move to the ```NumpyPandas_course-master/binder``` folder
3. Here you find an ```environment.yml``` file that you can use to create a conda environment. Choose an environment name e.g. ```numpypandas``` and type:
   ```
   conda env create -n numpypandas -f environment.yml
   ```
4. When you want to run the material, activate the environment and start jupyter:
   ```
   conda activate numpypandas
   jupyter lab
   ```
   Note that the top folder of your directory in Jupyter is the folder from where you started Jupyter. So if you are e.g. in the ```binder``` folder, move one level up to have access to the notebooks
