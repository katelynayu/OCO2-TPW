function field = nc_read_var_slice(filename, varname, start, count)
% Read a section of a netCDF variable
% nc_read_var_slice(filename, varname, start, count)
%
% Read a section of a netCDF variable and automatically set
% missing_value's and _FillValue's to NaN and
% apply scale_factor if it is present.
%
% Variables of type float are promoted to double.
% Other types are preserved.
%
% filename is the name of the file to read from
%
% varname is the name of the variable to be read
%
% start is an array of starting indices (0-based)
%    values of -1 are replaced with the dimension length - 1
%
% count is an array of index spans
%    values of -1 are replaced to read to the end of the dimensions

if (any(start == -1) || any(count == -1))
    dimlens = nc_read_var_dimlens(filename, varname);
    ind = find(start == -1);
    if ~isempty(ind)
       start(ind) = dimlens(ind) - 1;
    end;
    ind = find(count == -1);
    if ~isempty(ind)
        count(ind) = dimlens(ind) - start(ind);
    end;
end;

fid = netcdf.open(deblank(filename), 'NOWRITE');
varid = netcdf.inqVarID(fid, varname);

[tmp, xtype] = netcdf.inqVar(fid, varid);
if (xtype == netcdf.getConstant('FLOAT'))
    field = netcdf.getVar(fid, varid, start, count, 'double');
else
    field = netcdf.getVar(fid, varid, start, count);
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
