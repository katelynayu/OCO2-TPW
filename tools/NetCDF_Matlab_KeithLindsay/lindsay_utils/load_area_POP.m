function area = load_area_POP(filename)
% Construct area, m^2, for a POP grid stored in filename.
% load_area_POP(filename)

area = nc_read_var(filename,'TAREA');

% convert from cm^2 to m^2

area = area * 1e-4;
