function dimlens = nc_read_var_dimlens(filename, varname)
% Read dimlens for a netCDF variable
% nc_read_var_lon(filename, varname)
%
% filename is the name of the file to read from
%
% varname is the name of the variable to be read

fid = netcdf.open(deblank(filename), 'NOWRITE');
varid = netcdf.inqVarID(fid, varname);
[tmp1, tmp2, dimids] = netcdf.inqVar(fid, varid);
dimlens = zeros([1 length(dimids)]);
for dimnum = 1:length(dimids),
    [name, len] = netcdf.inqDim(fid, dimids(dimnum));
    dimlens(dimnum) = len;
end

netcdf.close(fid);
