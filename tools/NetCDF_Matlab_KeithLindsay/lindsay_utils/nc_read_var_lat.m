function field = nc_read_var_lat(filename, varname)
% Read latitude for a netCDF variable
% nc_read_var_lat(filename, varname)
%
% filename is the name of the file to read from
%
% varname is the name of the variable to be read

fid = netcdf.open(deblank(filename), 'NOWRITE');
varid = netcdf.inqVarID(fid, varname);

% first check for rectilinear coordinates
% check each dimension of varname to see if there
% is a variable with the same name
% if such a variable exists and it is a valid latitude,
% then we're done

[ndims_file, nvars_file] = netcdf.inq(fid);
[tmp1, tmp2, dimids] = netcdf.inqVar(fid, varid);
for dimnum = 1:length(dimids),
    dimname = netcdf.inqDim(fid, dimids(dimnum));
    for varnum = 0:nvars_file-1,
        varname_tmp = netcdf.inqVar(fid, varnum);
        if (strcmp(dimname, varname_tmp))
            if (has_att(fid, varnum, 'units') && is_lat(netcdf.getAtt(fid, varnum, 'units')))
                netcdf.close(fid);
                field = nc_read_var(filename, dimname);
                return;
            end;
        end;
    end;
end;

% scan coordinates attribute
% for each token, search for variable with token as its name
% if such a variable exists and it is a valid latitude,
% then we're done
if has_att(fid, varid, 'coordinates'),
    [coord_name remain] = strtok(netcdf.getAtt(fid, varid, 'coordinates'));
    while (~isempty(coord_name)),
        for varnum = 0:nvars_file-1,
            varname_tmp = netcdf.inqVar(fid, varnum);
            if (strcmp(coord_name, varname_tmp))
                if (has_att(fid, varnum, 'units') && is_lat(netcdf.getAtt(fid, varnum, 'units')))
                    netcdf.close(fid);
                    field = nc_read_var(filename, coord_name);
                    return;
                end;
            end;
        end;
        [coord_name remain] = strtok(remain);
    end;
end;

disp(['no latitude found for ' varname]);

field = 0;

netcdf.close(fid);
