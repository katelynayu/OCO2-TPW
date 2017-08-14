function field = nc_read_var(filename, varname)
% Read an entire netCDF variable
% nc_read_var(filename, varname)
%
% Read an entire netCDF variable and automatically set
% missing_value's and _FillValue's to NaN and
% apply scale_factor if it is present.
%
% Variables of type float are promoted to double.
% Other types are preserved.
%
% filename is the name of the file to read from
%
% varname is the name of the variable to be read

fid = netcdf.open(deblank(filename), 'NOWRITE');
varid = netcdf.inqVarID(fid, varname);

[tmp, xtype] = netcdf.inqVar(fid, varid);
if (xtype == netcdf.getConstant('FLOAT'))
    field = netcdf.getVar(fid, varid, 'double');
else
    field = netcdf.getVar(fid, varid);
end;

if has_att(fid, varid, 'missing_value')
    msv = nc_read_var_att(filename, varname, 'missing_value');
    field(find(field == msv)) = NaN;
end;
if has_att(fid, varid, '_FillValue')
    msv = nc_read_var_att(filename, varname, '_FillValue');
    field(find(field == msv)) = NaN;
end;

if has_att(fid, varid, 'scale_factor')
    field = field * nc_read_var_att(filename, varname, 'scale_factor');
end;

netcdf.close(fid);
