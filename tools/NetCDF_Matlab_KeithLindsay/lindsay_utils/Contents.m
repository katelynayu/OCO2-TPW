% Utility m-files for ASP Summer 2013 Colloquium
%
% Generic netCDF reading utilities
%   nc_read_var               - Read an entire netCDF variable
%   nc_read_var_dimlens       - Read dimlens for a netCDF variable
%   nc_read_var_slice         - Read a section of a netCDF variable
%   nc_read_var_lat           - Read latitude for a netCDF variable
%   nc_read_var_lon           - Read longitude for a netCDF variable
%   nc_read_var_att           - Read netCDF variable's attribute
%
% Area loading utilities
%
%   load_area_latlon.m        - Construct cell area for a lat-lon grid
%   load_area_CMIP.m          - Construct cell area for a model grid from the CMIP directory
%   load_area_ROMS.m          - Construct cell area for a ROMS grid
%   load_area_POP.m           - Construct cell area for a POP grid
%
% Time handling utilities
%
%   nc_read_var_time          - Read time for a netCDF variable
%   nc_read_var_time_slice    - Read a section of time for a netCDF variable
%   nc_read_var_time_calendar - Read time calendar for a netCDF variable
%   nc_read_var_time_units    - Read time units for a netCDF variable
%   time_to_year_offset       - convert time value to years of offset
%
% Misc utilities
%
%   comp_masked_weighted_mean - compute masked weighted mean of a variable
%   lonlat_to_logical         - convert lon-lat coordinates to logical indices
%   overlay_coastlines        - overlay contintental coastlines on a figure
%
% POP specific netCDF utilities
%   POP_Tcontour              - Generate contour plot for var on POP grid.
%   POP_Tcontourf             - Generate filled contour plot for var on POP grid.
%   POP_Tcolor                - Generate color shaded surface plot for var on POP grid.
%   POP_e_shift               - shift from east
%   POP_n_shift               - shift from north
%
% short functions used by some of the above
%   has_att                   - Does varid in fid have attname as an attribute?
%   is_lat                    - Does units represent valid latitude?
%   is_lon                    - Does units represent valid longitude?
%   is_time                   - Does units represent a handled time unit?
