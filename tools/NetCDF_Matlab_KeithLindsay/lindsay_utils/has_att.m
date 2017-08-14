function res = has_att(fid, varid, attname)
% Does varid in fid have attname as an attribute?
% has_att(fid, varid, attname)

[tmp1, tmp2, tmp3, natts] = netcdf.inqVar(fid, varid);

for attnum = 0:natts-1,
    if (strcmp(netcdf.inqAttName(fid, varid, attnum), attname))
        res = 1;
        return;
    end
end

res = 0;
