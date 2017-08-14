function area = load_area_CMIP(model)
% Construct area, m^2, for a CMIP model.
% load_area_CMIP(model)

data_dir = ['/project/colloquium/data/CMIP5/' model];

[status,result] = system(['find ' data_dir ' -type f -name "areacello*.nc"']);

if isempty(result)
    disp(['area file not found for ' model]);
    return;
end;

split_result = regexp(result, '\n', 'split');
filename = split_result{1};

area = nc_read_var(filename, 'areacello');
