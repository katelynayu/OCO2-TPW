% example3.m

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

% read time and convert to years offset from base date
time_raw = nc_read_var_time_slice(full_filename, varname, 0, year_count*12);
time_years = time_to_year_offset(time_raw, nc_read_var_time_units(full_filename, varname), ...
                                 nc_read_var_time_calendar(full_filename, varname));

pause;

% generate Nino 3.4 region mask
nino_34_mask = (lat >= -5) & (lat <= 5) & (lon >= (360-170)) & (lon <= (360-120));

% load area for proper averaging
area = load_area_CMIP(model);

pause;

nino_34_field = comp_masked_weighted_mean(field, nino_34_mask, area);

plot(time_years, nino_34_field);
title([varname ' in Nino 3.4 Region']);
xlabel('Model Year');
ylabel(units);

pause;

% do the same for SST

SST_varname = 'tos';
realm   = 'ocean';

sub_dir = [ model '/' expr '/' freq '/' realm '/' rfreq '/' ens '/' SST_varname ];

filename = [ SST_varname '_' rfreq '_' model '_' expr '_' ens '_' datestr '.nc' ];

full_filename = [data_dir '/' sub_dir '/' filename];

SST = nc_read_var_slice(full_filename, SST_varname, [0 0 0], [-1 -1 year_count*12]);
SST_units = nc_read_var_att(full_filename, SST_varname, 'units');

nino_34_SST = comp_masked_weighted_mean(SST, nino_34_mask, area);

plot(time_years, nino_34_SST);
title([SST_varname ' in Nino 3.4 Region']);
xlabel('Model Year');
ylabel(SST_units);

pause;

% 2 axes on 1 figure

ax = plotyy(time_years, nino_34_field, time_years, nino_34_SST);
title([varname ' & SST in Nino 3.4 Region']);
xlabel('Model Year');
ylabel(ax(1), units);
ylabel(ax(2), SST_units);
legend(varname, 'SST');

pause;

corr(nino_34_field, nino_34_SST)

pause;

% do the previous plot for monthly anomalies

nino_34_field_anom = nino_34_field;
nino_34_SST_anom = nino_34_SST;
for mon = 1:12,
    nino_34_field_anom(mon:12:end) = nino_34_field_anom(mon:12:end) - ...
                                       mean(nino_34_field_anom(mon:12:end));
    nino_34_SST_anom(mon:12:end) = nino_34_SST_anom(mon:12:end) - ...
                                   mean(nino_34_SST_anom(mon:12:end));
end;

% 2 axes on 1 figure

ax = plotyy(time_years, nino_34_field_anom, time_years, nino_34_SST_anom);
title([varname ' & SST Monthly Anomalies in Nino 3.4 Region']);
xlabel('Model Year');
ylabel(ax(1), units);
ylabel(ax(2), SST_units);
legend(varname, 'SST');

pause;

corr(nino_34_field_anom, nino_34_SST_anom)

pause;

% correlation of global monthly anomalies vs nino_34_SST_anom

% compute monthly anomalies

field_anom = field;
for mon = 1:12,
    field_mon_mean = mean(field_anom(:,:,mon:12:end),3);
    field_anom(:,:,mon:12:end) = field_anom(:,:,mon:12:end) - ...
                                   repmat(field_mon_mean, [1 1 year_count]);
end;

% first make map of standard deviation of monthly anomalies
clf;
POP_Tcontourf(lon,lat,std(field_anom,0,3));
title_str = ['Std Dev of ' varname ' Monthly Anomalies, (' units ')'];
title(title_str);
overlay_coastlines;

pause;

% correlate anomalies with nino_34_SST_anom
% corr does not work on multidimensional variables, so flatten out spatial dimensions

field_size = size(field_anom);
field_spaceflat = reshape(field_anom, [field_size(1)*field_size(2) field_size(3)]);
% field_sst_corr_space_flat = corr(nino_34_SST_anom, field_spaceflat);
%
% Error using corr (line 102)
% X and Y must have the same number of rows.
%
% whoops! what went wrong
pause;
size(nino_34_SST_anom)
size(field_spaceflat)

% transpose (denoted by ') on field_spaceflat
pause;

field_sst_corr_space_flat = corr(nino_34_SST_anom, field_spaceflat');

pause;

% convert flattened space back to 2D
field_sst_corr = reshape(field_sst_corr_space_flat, [field_size(1) field_size(2)]);

pause;

% make a map of the results
clf;
POP_Tcontourf(lon,lat,field_sst_corr);
title_str = ['Corr between ' varname ' Monthly Anomalies & Nino 34 SST anom'];
title(title_str);
overlay_coastlines;
colorbar;
