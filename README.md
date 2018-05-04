The first step in getting OCO2 total column water vapor (tcwv) ready for analysis is to download the Lite files for the time period of interest. 

To do this, follow these instructions:
https://docs.google.com/document/d/1v5XqQhiAAhLUkSK8HMb5ZCfM7rgp_2SHRqsHW2sRIt4/edit?usp=sharing

Then you'll have data in data/B7305Br that you can convert into mat-files (for matlab analysis) using the scripts in the scripts folder here:
read_lite_data_tpw_DAILY.m will read each daily file and save the data to a corresponding daily matfile.
read_lite_data_tpw_ALL.m will read all days and concatenate them together into one big matfile

There are also 2 scripts for plotting either one day of observations on a map, or plotting all of the observations in your large matfile onto a map.
plot_tpw_DAILY.m
&
plot_tpw_ALL.m

The output maps of these scripts for Jan 1 - Feb  7 2017 can be found in the scripts directory as png files.
