# What is autoRICEWQ?
This project aims to be a handler for input creation and running of multiple [RICEWQ](https://www.waterborne-env.com/model/ricewq-19/) simulations.

# What is RICEWQ?

From the description in its [website](https://www.waterborne-env.com/model/ricewq-19/):

> ## RICEWQ 1.92
> Rice production presents a unique problem with respect to agrochemical runoff because of the high seasonal rainfall, water management, and proximity of cropland to surface water bodies. Existing pesticide transport models are not configured to simulate the flooding conditions, overflow, and controlled releases of water that are typical under rice >production. RICEWQ was developed to simulate water and chemical mass balance associated with these unique governing processes.
>Water mass balance takes into account precipitation, evaporation, seepage, overflow, irrigation, and drainage. Pesticide mass balance can accommodate dilution, advection, volatilization, partitioning between water/sediment, decay in water and sediment, burial in sediment, and re-suspension from sediment. The model can simulate up to five chemicals/metabolites.
> ## MODEL REGISTRATION
> RIVWQ is an aquatic fate and transport model for evaluating flowing water scenarios. Although our models are distributed as freeware, donations are encouraged to cover costs for model development, distribution, and technical support.
>
>Please contact info@waterborne-env.com to register to receive a download of this model.

# What is the problem?

The problem is the input data for RICEWQ 1.92 lies on an input text file with an absolute format dependence. Tailoring by hand the correct input data to run a simulation is very time consuming and tedious. Thus, **this project aims to offer a very simple way to (1) parse input from Excel files, (2) run the RICEWQ 1.92 model and (3) parse the output back into Excel**. This facilitates the process of running hundreds or even thousands of simulations with ease.

# Installation

First, you will need to install [git](https://git-scm.com/), if you don't have it already.

Next, clone this repository by opening a terminal and typing the following commands:

    $ cd $HOME  # or any other development directory you prefer
    $ git clone https://github.com/backmind/autoRICEWQ.git
    $ cd autoRICEWQ

If you do not want to install git, you can instead download [main.zip](https://github.com/backmind/autoRICEWQ/archive/refs/heads/main.zip), unzip it, rename the resulting directory to `autoRICEWQ` and move it to your development directory.

If you are familiar with Python and you know how to install Python libraries, go ahead and install the libraries listed in `requirements.txt` and jump to the [Copy RICEWQ engine](#copy-ricewq-engine) section. If you need detailed instructions, please read on.

## Python 
Of course, you obviously need Python. Python 3 is already preinstalled on many systems nowadays. You can check which version you have by typing the following command (you may need to replace `python3` with `python`):

    $ python3 --version  # for Python 3

Any Python 3 version should be fine, preferably 3.5 or above. If you don't have Python 3, I recommend installing it. To do so, you have several options: on Windows or MacOSX, you can just download it from [python.org](https://www.python.org/downloads/). On MacOSX, you can alternatively use [MacPorts](https://www.macports.org/) or [Homebrew](https://brew.sh/). 

On Linux, unless you know what you are doing, you should use your system's packaging system. For example, on Debian or Ubuntu, type:

    $ sudo apt-get update
    $ sudo apt-get install python3 python3-pip

Another option is to download and install [Anaconda](https://www.continuum.io/downloads). This is a package that includes both Python and many scientific libraries. You should prefer the Python 3 version.

## Required Libraries

These are the commands you need to type in a terminal if you want to use pip to install the required libraries.

First you need to make sure you have the latest version of pip installed:

    $ python3 -m pip install --user --upgrade pip

The `--user` option will install the latest version of pip only for the current user. If you prefer to install it system wide (i.e. for all users), you must have administrator rights (e.g. use `sudo python3` instead of `python3` on Linux), and you should remove the `--user` option. The same is true of the command below that uses the `--user` option.

Next, use pip to install the required python packages. If you are not using virtualenv, you should add the `--user` option (alternatively you could install the libraries system-wide, but this will probably require administrator rights, e.g. using `sudo pip3` instead of `pip3` on Linux).

    $ python3 -m pip install --upgrade -r requirements.txt

## Copy RICEWQ engine

As this project is a handler for input creation and running of multiple RICEWQ 1.92 simulations, **you need RICEWQ 1.92 binaries**. Contact info@waterborne-env.com to receive a download. RICEWQ 1.92 binaries are freeware but as waterborne-env have no public direct download, this project autoRICEWQ is not sharing it. Once you have the binaries you should copy **RICE192.EXE** inside of the folder \\autoRICEWQ\\**bin\\**

Great! You're all set!

# Utilisation
It is very recommended to be familiarized with RICEWQ model or to check the manual that comes with it to understand the meaning of the multiple inputs the model needs.

To run autoRICEWQ you need to have the [input files](#input-files-setting-up) ready and the [meteorological data](#meteorological-data). The, you can run the simulations just by executing **RICE192.bat** on Windows or the next command line at **\\autoRICEWQ\\** folder in any system:

    $ python3 RICE192.py arg
    
where _arg_ can be **y** or **n** to halt on errors of keep with the remaining simulations if errors respectively.

## Input Files setting up
In order to run simulations, you need to create the input files you want to run. You can find examples of those files inside \\autoRICEWQ\\**input\\**, they are three:
1. inp_sim.xlsx: data related to the dates of the simulation, the area of the crops, and so on
2. inp_hidro.xlsx: data regarding the water balance of the crops
3. inp_chem.xlsx: data of the chemicals, metabolites, and its characteristics

Each one of these files can have multiple sheets, and there will be a number of simulations equal to the cartesian multiplication of sheets. Then, if you have four inp_sim sheets, two inp_hidro sheets and seven chemicals sheets you will end running 4×2×7=56 simulations.

**Sheetnames matter, only the sheets with a name starting with "+", wherever the file, will be simulated**.

## Meteorological data
Any RICEWQ simulation needs meteorological data. This data should exist for the range of dates the simulation is running, and it comprehends Date, Mean temperature (ºC), Precipitation (mm) and evapotranspiration. You can find examples of this files at the folder \\autoRICEWQ\\**meteo_data\\**.

All the filenames in \\meteo_data\\ are in de form **CODE**\_XXX, where CODE identifies a specific meteo data. This CODE is attached to a simulation through _inp\_sim_ D6 cell. 

## Output files
autoRICEWQ automatically handles the output from RICEWQ and parses it into Excel. Then, a new folder with the results is created at \\autoRICEWQ\\**results\\**, the name of the folders is in the form: 

    "inp_sim sheetname" [("inp_sim custom_label")] + _ + "inp_hidro sheetname" + _ + "inp_chem sheetname"
    
where the optional part of ("inp_sim custom_label") will be there if and only if cell D2 from inp_sim, which refers to a custom label for de simulation, is different of the current inp_sim sheetname.

### Errors and exceptions
In the devious case of an error during the execution occurs, output files will be moved to the same folder indicated in [Output files](#output-files) but with a preceding "ERROR-" word in the folder name. Inside the folder will be a file "run.log" with the info of the error. Those errors are registered nevertheless they are coming from autoRICEWQ or from RICEWQ, in order to accurately help to fix them.

# Disclaimer
The contributors of autoRICEWQ are not part of the team nor involved with RICEWQ or Waterborne Environmental, Inc. The autor of autoRICEWQ wants to thank Waterborne Environmental, Inc. for the development of the RICEWQ software and model, which is really useful.
