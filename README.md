# README: Protein mobility by FRAP

## Installation

### Using pip

Just make sure to install `pybioimage` to your local Python environment.

````commandline
pip install pybioimage
````


## Project structure

The overall project structure, i.e. the folder organization of the project, 
is outlined below. Each folder (in alphabetic order) is explained in more 
detail below. In general, the project follows a separation of raw and 
processed data from analysis scripts and output.conda 

```commandline
protein_mobility
├───css
├───data
│   ├───processed
│   │   ├───date-20220215_prot-m6_allele-wt_expr-homo_emb-1
│   │   ├───...
│   │   └───date-20231117_prot-aka_allele-pdzb_expr-homo_emb-56
│   └───raw
│       ├───date-20220215_prot-m6_allele-wt_expr-homo_emb-1
│       ├───...
│       └───date-20231117_prot-aka_allele-pdzb_expr-homo_emb-56
├───notebooks
├───output
│   ├───movies
│   ├───plots
│   └───tables
└───scripts
```


### The ``\data`` folder

> **IMPORTANT:** Since the data makes up for most of the required space of this 
project it is kept in a ZIP archive for long-term storage. The ZIP archive 
was generated with 7zip using the LZMA2 algorithm and it is recommended to 
use 7zip also for decompression (though every decent software should work). 
The ZIP archive allows to only extract certain subfolders/files instead of 
> the whole dataset. Please make sure to directly extract to the top-level 
> project folder to reconstitute proper folder organization. 

The data folder contains two subfolders: ``\raw`` and ``\processed``. The 
first one contains raw data, i.e., movies from the microscope. The only 
processing step applied here was to save the movies as single TIFFs from the 
Leica file format. Each movie is stored in its own folder. The folder 
contains typically two files:

* ``movie.tif`` is the raw image from the microscope.
* ``movie_avg.tif`` is a mean intensity projection from the relevant slices. 
  This is the file used for analysis.

Metadata for each movie is stored in the folder name, which is of the format 
``date-[YYYYmmdd]_prot-[protein]_allele-[allele]_expr-[expression]_emb-
[number]``. The components should be self-explanatory. Only *allele* might 
be a bit misleading as it does not necessarily refer to the allele of the 
observed protein. Therefor, during processing, this variable is renamed to 
*Condition*. The folder name is automatically processed by Python and the 
contained metadata is added to the output CSV file. Generally, data not 
considered for analysis is stored in folders with a leading underscore.

The ``\processed`` folder contains intermediate files. This includes the 
measured intensities for each movie as a CSV file as well as registered 
movies and kymographs.


### The ``\notebooks`` folder

This folder contains a Jupyter notebook that demonstrates precisely how the 
data was analyzed. This can also serve as a primer for using the code in 
this project for other FRAP projects.


### The ``\output`` folder

This folder contains all the final output from the analysis. It contains 
four subfolders explained below.

* ``\plots`` contains graphical output in PDF and PNG format (each in 
  accordingly named folders). Be aware that this does not necessarily 
  contain all analyzed proteins but only those that were shown in a 
  presentation or publication.
* ``\tables`` contains the final processed tables as well as summary tables 
  in separate CSV files. For convenience, the folder also contains an EXCEL 
  file with all tables as separate sheets.
* ``\movies`` contains annotated movies intended for use in publications.


### The ``\scripts`` folder

````commandline
└───scripts
    ├───main.py
    └───R
        ├───main.R
        ├───...
        └───helpers
            ├───_panel.error.R
            └───...
````

This is the place where the Python and R scripts live that actually do the 
analysis and generate output tables and plots. As said, this is a mixture of 
Python and R scripts. In general, Python was used to read and process the 
raw data. In particular, Python did everything that included direct handling 
of image files. The R programming package was used for final data cleaning, 
statistical analysis, curve fitting, and generating plots and output tables. 
A brief explanation of each files can be found in the following. For more 
details, consult the code and code comments as well as the demo notebook. 
Files starting with an underscrore contain helper functions (this might be 
refactored at some time).

* ``main.py`` reads the raw data from the subfolders in 
  ``\data\raw`` and processes them. The output includes a CSV file as well 
  as registered movies and kymographs. This output is stored in 
  corresponding subfolders of ``\data\processed``.
* ``main.R`` coordinates execution of all R scripts. 

> **IMPORTANT:** All these scripts have to be executed at the top-level 
> folder of the project, not within the ``scripts`` folder.