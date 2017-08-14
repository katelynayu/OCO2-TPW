function area = load_area_ROMS(filename)
% Construct area, m^2, for a ROMS grid stored in filename.
% load_area_ROMS(filename)

pm = nc_read_var(filename,'pm');
pn = nc_read_var(filename,'pn');
area = 1.0 ./ (pm .* pn);
