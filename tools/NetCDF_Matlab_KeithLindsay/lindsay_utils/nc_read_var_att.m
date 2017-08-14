function att = nc_read_var_att(filename, varname, attname)
% Read netCDF variable's attribute
% nc_read_var_att(filename, varname, attname)
%
% Attributes of type float are promoted to double.
% Other types are preserved.
%
% filename is the name of the file to read from
%
% varname is the name of the variable to read from
%
% attname is the name of the attribute to be read

fid = netcdf.open(deblank(filename), 'NOWRITE');
varid = netcdf.inqVarID(fid, varname);

xtype = netcdf.inqAtt(fid, varid, attname);
if (xtype == netcdf.getConstant('FLOAT'))
    att = netcdf.getAtt(fid, varid, attname, 'double');
else
    att = netcdf.getAtt(fid, varid, attname);
end;

netcdf.close(fid);
