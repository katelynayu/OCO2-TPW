% example4.m

echo on;

axis_bnds = [125 240 30 65];

varname = 'fgco2';
year_count = 20;

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

% generate mask of interest, plot it
figure(1); clf;
mask = (lon >= axis_bnds(1)) & (lon <= axis_bnds(2)) & (lat >= axis_bnds(3)) & (lat <= axis_bnds(4)) & isfinite(field(:,:,1));
POP_Tcolor(lon,lat,mask);
overlay_coastlines;
axis(axis_bnds);
mask_ind = find(mask);

pause;

% compute monthly anomalies

field_anom = field;
for mon = 1:12,
    field_mon_mean = mean(field_anom(:,:,mon:12:end),3);
    field_anom(:,:,mon:12:end) = field_anom(:,:,mon:12:end) - ...
                                   repmat(field_mon_mean, [1 1 year_count]);
end;

pause;

% generate flattened matrix for matlab's svd routine
field_size = size(field_anom);
tmp = reshape(field_anom, [field_size(1)*field_size(2) field_size(3)]);
field_anom_mask_flat = tmp(mask_ind,:);
size(field_anom_mask_flat)

pause;

% compute SVD
[U, S, V] = svd(field_anom_mask_flat);
VSp = V*S';
pause;

% extract, and plot, first EOF from U
figure(1); clf;
EOF1 = zeros([field_size(1) field_size(2)]) + NaN;
EOF1(mask_ind) = U(:,1);
POP_Tcolor(lon,lat,EOF1);
colorbar;
overlay_coastlines;
title('first EOF');
axis(axis_bnds);

pause;

% extract, and plot, corresponding timeseries
figure(2); clf;
plot(time_years, VSp(:,1));
title('timeseries for 1st EOF');
xlabel('Model Year');

pause;

% how well does this represent values at (lon,lat)=(180,57)

[i, j] = lonlat_to_logical(180, 57, lon, lat, mask);
figure(2); clf;
plot(time_years, [squeeze(field_anom(i,j,:)) EOF1(i,j)*VSp(:,1)]);
title('first EOF performance at (180,57)');
xlabel('Model Years');

pause;

% how well does this represent values at (lon,lat)=(170,40)

[i, j] = lonlat_to_logical(170, 40, lon, lat, mask);
figure(2); clf;
plot(time_years, [squeeze(field_anom(i,j,:)) EOF1(i,j)*VSp(:,1)]);
title('first EOF performance at (170,40)');
xlabel('Model Years');

pause;

% how well does this represent values at (lon,lat)=(220,45)

[i, j] = lonlat_to_logical(230, 45, lon, lat, mask);
figure(2); clf;
plot(time_years, [squeeze(field_anom(i,j,:)) EOF1(i,j)*VSp(:,1)]);
title('first EOF performance at (230,45)');
xlabel('Model Years');

pause;

% how much variance is explained?

var_explained = diag(S).^2;
cum_var_explained = cumsum(var_explained) / sum(var_explained);
figure(2); clf;
plot(cum_var_explained, '-o');
title('cumulative relative variance explained');
axis([0 100 0 1]);

