function res = is_lat(units)
% Does units represent valid latitude?
% is_lat(units)

valid = {'degrees_north', 'degree_north', 'degree_N', 'degrees_N', 'degreeN', 'degreesN'};
res = any(strcmp(units, valid));
