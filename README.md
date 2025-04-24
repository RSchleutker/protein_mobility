<h1>README: Protein mobility by FRAP</h1>

* **Author:** Raphael Schleutker
* **Last updated:** 2024-04-16


<h2>Installation</h2>

<h3>Using *pip*</h3>

Just make sure to install `pybioimage` to your local Python environment.

````commandline
pip install pybioimage
````


<h2>Project structure</h2>

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
│   │   ├───date-20220215_prot-m6_allele-wt_expr-homo_emb-2
│   │   ├───...
│   │   ├───date-20231117_prot-aka_allele-pdzb_expr-homo_emb-55
│   │   └───date-20231117_prot-aka_allele-pdzb_expr-homo_emb-56
│   └───raw
│       ├───date-20220215_prot-m6_allele-wt_expr-homo_emb-1
│       ├───date-20220215_prot-m6_allele-wt_expr-homo_emb-2
│       ├───...
│       ├───_date-20220118_prot-m6aka_allele-wt_expr-homo_emb-4
│       └───_date-20220118_prot-m6aka_allele-wt_expr-homo_emb-5
├───notebooks
├───output
│   ├───movies
│   ├───plots
│   │   ├───pdf
│   │   └───png
│   └───tables
├───protein_mobility
│   └───__pycache__
└───scripts
```


<h3>The ``\data`` folder</h3>

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


<h3>The ``\notebooks`` folder</h3>

This folder contains a Jupyter notebook that demonstrates precisely how the 
data was analyzed. This can also serve as a primer for using the code in 
this project for other FRAP projects.


<h3>The ``\output`` folder</h3>

This folder contains all the final output from the analysis. It contains 
four subfolders explained below.

* ``\plots`` contains graphical output in PDF and PNG format (each in 
  accordingly named folders). Be aware that this does not necessarily 
  contain all analyzed proteins but only those that were shown in a 
  presentation or publication.
* ``\tables`` contains the final processed tables as well as summary tables 
  in separate CSV files. For convenience, the folder also contains an EXCEL 
  file with all tables as separate sheets.
* ``\statistics`` contains results from statistical tests and curve fitting.
* ``\movies`` contains annotated movies intended for use in publications.


<h3>The ``\protein_mobility`` package</h3>

In accordance with Python naming conventions the main code of this project 
lives in a folder named as the overall project, i.e. ``\protein_mobility``. 
As this is a regular Python package it contains an ``__init__.py`` file 
marking it as such (if you are not familiar with this I recommend reading an 
introductory book on Python programming). This package contains the function 
that are used throughout the project, for instance in notebooks and scripts. 
This package does not contain code that actually runs the analysis. For that,
see the ``\scripts`` folder.


<h3>The ``\scripts`` folder</h3>

````commandline
└───scripts
        analyze_movies.py
        data_processing.R
        statistics.R
        visualize.R
        _panel.error.R
        _plot_template.R
        _theme.R
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

* ``analyse_movies.py`` reads the raw data from the subfolders in 
  ``\data\raw`` and processes them. The output includes a CSV file as well 
  as registered movies and kymographs. This output is stored in 
  corresponding subfolders of ``\data\processed``.
* ``data_processing.R`` takes the raw measurements generated by Python and 
  stored in the subfolders of ``\data\processed`` and combines them into one 
  table that is stored in ``\output\tables``.
* ``visualize.R`` contains all the R code to generate plots. It assumes a 
  processed data tables (generated by ``data_processing.R``). Plots are 
  stored in both PDF and PNG format.

> **IMPORTANT:** All these scripts have to be executed at the top-level 
> folder of the project, not within the ``scripts`` folder.


<h2>Experimental information</h2>

<h3>Fly stocks</h3>

The following table gives an overview of the used fly stocks. The identifier 
is a combination of protein, genetic background, and homo- or heterozygous 
expression as found in the cleaned data tables found in ``\output\tables``.

To be continued...


<h3>Microscope setup</h3>