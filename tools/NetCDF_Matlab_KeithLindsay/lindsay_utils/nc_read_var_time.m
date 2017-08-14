function time = nc_read_var_time(filename, varname)
% Read time for a netCDF variable
% nc_read_var_time(filename, varname)
%
% filename is the name of the file to read from
%
% varname is the name of the variable to be read
%
% units of output are the same as in the file,
% use nc_read_var_time_units to retreive the units

fid = netcdf.open(deblank(filename), 'NOWRITE');
varid = netcdf.inqVarID(fid, varname);

% assume time is not curvilinear with other coordinates
% so only checktime for netCDF coordinate variables
% also assume time is the last dimension, if it is present
% check the last dimension of varname to see if there
% is a variable with the same name
% if such a variable exists and its units starts with
% 'days since' or 'seconds since' then this is what we want

[ndims_file, nvars_file] = netcdf.inq(fid);
[tmp1, tmp2, dimids] = netcdf.inqVar(fid, varid);
dimnum = length(dimids);
dimname = netcdf.inqDim(fid, dimids(dimnum));
for varnum = 0:nvars_file-1,
    varname_tmp = netcdf.inqVar(fid, varnum);
    if (strcmp(dimname, varname_tmp))
        if has_att(fid, varnum, 'units')
            if is_time(netcdf.getAtt(fid, varnum, 'units'))
                netcdf.close(fid);
                time = nc_read_var(filename, dimname);
                return;
            end;
        end;
    end;
end;

disp(['no time found for ' varname]);

time = 0;

netcdf.close(fid);
