function [i, j] = lonlat_to_logical(lon0, lat0, lon_array, lat_array, mask)
% find logical indices whose location is closest to a specified location
% [i, j] = lonlat_to_logical(lon0, lat0, lon_array, lat_array, mask)
%
% find logical indices whose location is closets to a specified location
%
% lon0, lat0 are coordinates of the specified location
%
% lon_array, lat_array are coordinates of a grid, 1D or 2D
%
% mask, which is optional, specifies which grid locations are to be considered
% if mask is not present, it is assumed to be all ones

if (any(size(lon_array) == 1))
    lon_len = length(lon_array);
else
    lon_len = size(lon_array,1);
end;

if (any(size(lat_array) == 1))
    lat_len = length(lat_array);
else
    lat_len = size(lat_array,2);
end;

if (nargin == 4)
    mask = ones([lon_len lat_len]);
end;

if (any(size(lon_array) == 1))
    lon2d = repmat(reshape(lon_array, [lon_len 1]), [1 lat_len]);
else
    lon2d = lon_array;
end;

if (any(size(lat_array) == 1))
    lat2d = repmat(reshape(lat_array, [1 lat_len]), [lon_len 1]);
else
    lat2d = lat_array;
end;

z0 = sin(lat0*(pi/180));
x0 = cos(lat0*(pi/180)) * cos(lon0*(pi/180));
y0 = cos(lat0*(pi/180)) * sin(lon0*(pi/180));

ind = find(mask);

z2d_flat = sin(lat2d(ind)*(pi/180));
tmp = cos(lat2d(ind)*(pi/180));
x2d_flat = tmp .* cos(lon2d(ind)*(pi/180));
y2d_flat = tmp .* sin(lon2d(ind)*(pi/180));

dp_2d_flat = x0 * x2d_flat + y0 * y2d_flat + z0 * z2d_flat;
[val, i_flat] = max(dp_2d_flat);

[i, j] = ind2sub(size(mask), ind(i_flat));
