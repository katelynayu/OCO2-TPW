% example2.m

echo on;

varname = 'intpp';
year_count = 50;

model   = 'CESM1-BGC';
expr    = 'esmControl';
freq    = 'mon';
realm   = 'ocnBgchem';
rfreq   = 'Omon';
ens     = 'r1i1p1';
datestr = '030101-080012';

data_dir = '/project/colloquium/data/CMIP5';

sub_dir = [ model '/' expr '/' freq '/' realm '/' rfreq '/' ens '/' varname ];

filename = [ varname '_' rfreq '_' model '_' expr '_' ens '_' datestr '.nc' ];

full_filename = [data_dir '/' sub_dir '/' filename]

field = nc_read_var_slice(full_filename, varname, [0 0 0], [-1 -1 year_count*12]);
units = nc_read_var_att(full_filename, varname, 'units');
size(field)
pause

lon = nc_read_var_lon(full_filename, varname);
lat = nc_read_var_lat(full_filename, varname);

% contour plot of Annual mean

contourf(lon, lat, mean(field,3));
title_str = ['Annual Mean ' varname ' (' units ')'];
title(title_str);
overlay_coastlines;
colorbar;

pause;

POP_Tcontourf(lon, lat, mean(field,3));
title_str = ['Annual Mean ' varname ' (' units ')'];
title(title_str);
overlay_coastlines;
colorbar;

pause;

% contour plot of December mean

POP_Tcontourf(lon, lat, mean(field(:,:,12:12:end),3));
title_str = ['December ' varname ' (' units ')'];
title(title_str);
overlay_coastlines;
colorbar;

pause;

% contour plot of April mean

POP_Tcontourf(lon, lat, mean(field(:,:,4:12:end),3));
title_str = ['April ' varname ' (' units ')'];
title(title_str);
overlay_coastlines;
colorbar;
