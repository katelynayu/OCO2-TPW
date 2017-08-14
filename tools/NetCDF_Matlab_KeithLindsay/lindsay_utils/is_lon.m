function res = is_lon(units)
% Does units represent valid longitude?
% is_lon(units)

valid = {'degrees_east', 'degree_east', 'degree_E', 'degrees_E', 'degreeE', 'degreesE'};
res = any(strcmp(units, valid));
