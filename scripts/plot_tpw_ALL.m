% plot_tpw_ALL.m

% This just plots a scatter plot of the TPW OCO2 data -- 
% The data was saved as .mat files using read_lite_data_tpw.m

addpath('../tools')
addpath('../tools/NetCDF_Matlab_KeithLindsay/lindsay_utils/')

% Read in all the TPW data the big mat-file with many days in it:

fname = '../data/B7305-MAT/OCO2_TPW_ALL.mat';
load(fname)

startdate = datestr(min(data.datenum),'mm/dd/yyyy');
enddate = datestr(max(data.datenum), 'mm/dd/yyyy');

scatter(data.longitude, data.latitude, 10, data.tcwv, 'filled')
colorbar
title(['OCO2 TCWV (kg/m2) ' startdate '--' enddate], 'FontSize', 20)
set(gca,'FontSize', 20)
overlay_coastlines
xlim([-180 180])

print_landscape_fill_page(gcf,'TPW_Map.png')

