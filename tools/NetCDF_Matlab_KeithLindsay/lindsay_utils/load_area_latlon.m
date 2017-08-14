function area = load_area_latlon(filename)
% Construct area, m^2, for a lat-lon grid stored in filename.
% load_area_latlon(filename)

lat = nc_read_var(filename,'lat');
lon = nc_read_var(filename,'lon');

radius = 6.37122e6;

nlat = length(lat);
lat_edge = zeros(nlat+1,1);
lat_edge(1) = max(-90, lat(1)-0.5*(lat(2)-lat(1)));
lat_edge(2:nlat) = 0.5*(lat(1:nlat-1) + lat(2:nlat));
lat_edge(nlat+1) = min(90, lat(nlat) + 0.5*(lat(nlat) - lat(nlat-1)));
dlat = diff(lat_edge);

nlon = length(lon);
lon_edge = zeros(nlon+1,1);
lon_edge(1) = lon(1)-0.5*(lon(2)-lon(1));
lon_edge(2:nlon) = 0.5*(lon(1:nlon-1) + lon(2:nlon));
lon_edge(nlon+1) = lon(nlon) + 0.5*(lon(nlon) - lon(nlon-1));
dlon = diff(lon_edge);

[dlon_2d, dlat_2d] = meshgrid(dlon, dlat);
[lon_2d, lat_2d] = meshgrid(lon, lat);

dy = radius * (dlat_2d * (pi/180.0));
dx = radius * (dlon_2d * (pi/180.0)) .* cos(lat_2d * (pi/180.0));

area = dx .* dy;
