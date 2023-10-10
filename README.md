# School Shootings Increase NRA Donations
This is the replication code for the paper: Roemer, Tobias (2023): “School Shootings Increase NRA Donations”

# How to run
1. Download the repo
2. Open the .RProj
3. Install `pacman` by running `install.packages("pacman")` if not installed yet. `pacman` is used to load and install all further dependencies
4. Run the `00_main_analysis.R` file, which will automatically install all dependencies and call the individual source files that create the main plots. Plots will be saved in the `figures` folder. The map and all supplementary analyses can be reproduced by running `01_maps.R` and `02_supplementary_analysis.R` respectively. Should you encounter any difficulties, please email me at: tobias.roemer@nuffield.ox.ac.uk

# Code Files
```bash
.
├── 00_main_analysis (reproduces figures from main text)
│   ├── 00_main_figure.R (Figure 2)
│   ├── 01_het_restrictiveness.R (Figure 3.A)
│   └── 02_het_fatalities.R (Figure 3.B)
├── 00_main_analysis.R
├── 01_maps (reproduces map from main text)
│   └── 00_shootings_map.R (Figure 1)
├── 01_maps.R
├── 02_supplementary_analysis (reproduces supplementary information)
│   ├── 00_het_time_trends.R (Figure SI.3.1)
│   ├── 01_adjacency_treatment.R (Figure SI.4)
│   ├── 02_adjacency_control.R (Figure SI.3.2)
│   ├── 03_leave_one_out.R (Figure SI.5)
│   ├── 04_alt_estimators.R (Figure SI.6.1)
│   ├── 05_nra_donations_pah_et_al_coding.R (Figure SI.2.2)
│   ├── 06_twfe.R (Figure SI.6.2)
│   ├── 07_mother_jones.R (Figure SI.2.3)
│   ├── 08_rampage_shootings.R (Figure SI.2.1)
│   ├── 09_not_yet_treated_as_control.R (Figure SI.3.3)
│   ├── 10_placebos.R (Figure SI.1)
│   ├── 11_no_fatalities_analysis.R (Figure SI.10.1, Figure SI.10.2)
│   ├── 12_giffords.R (Figure SI.9)
│   ├── 13_donations_and_mobilization_cces.R (Table SI.7)
│   ├── 14_political_participation_after_shootings_cces.R (Table SI.11)
│   ├── 15_nra_ad_spending.R (Figure SI.8.A)
│   └── 16_nra_ad_audience_size.R (Figure SI.8.A)
├── 02_supplementary_analysis.R
└── 03_functions
    ├── estimate_att.R
    ├── plot_functions_alt_est.R
    ├── plot_functions_main.R
    └── plot_functions_sun.R
```

# Dependencies
The code used in this repo requires the following R packages:
- 00_main
	- tidyverse
	- did
	- fixest
- 01_maps
	- tidyverse
	- usmap
- 02_supplementary_analyses
	- tidyverse
	- did
	- fixest
	- broom
	- tigris
	- modelsummary
	- didimputation
	- DIDmultiplegt