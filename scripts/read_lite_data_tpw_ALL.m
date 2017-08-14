% This is similar to the read_lite_data_tpw_DAILY.m script
% Except instead of saving daily mat-files, it saves one mat-file with all
% of the days in ../data/B7305Br in it (big file)

% datadir is wherever you have your Lite files stored
% Stephanie has Jan 1 2017 through Feb 8 data in this directory:
datadir = '/Users/stephanie/projects/cda/co2data/oco2/lite/B7305Br/';
addpath(datadir)
savedir = '/Users/stephanie/projects/cda/co2data/oco2/lite/B7305Br_MAT/';

% Get a list of all the files you want to read in in a particular directory
files = {}; flist = [];
filecount = 0; filecount2 = 0;
bad_file_inds2 = NaN;
filenames = dir([datadir 'oco2_LtCO2*nc4']);
for i = 1:numel(filenames)
    files{i} = filenames(i).name;
end
files = char(files);

% Read in the first file
file = files(1,:);
% Main Level Variables.
data.time = h5read(file,'/time')'; % seconds since Jan 1, 1993: for above 559.420571E6.
data.longitude = h5read(file,'/longitude')';
data.latitude = h5read(file,'/latitude')';
data.solar_zenith_angle = h5read(file,'/solar_zenith_angle')';
data.xco2 = h5read(file,'/xco2')';
data.xco2_apriori = h5read(file,'/xco2_apriori')';
data.xco2_uncert = h5read(file,'/xco2_uncertainty')';
data.xco2_quality_flag = h5read(file,'/xco2_quality_flag')';
data.warn_level = h5read(file,'/warn_level')';
data.sounding_id = h5read(file,'/sounding_id')';
data.source_files = h5read(file,'/source_files')';
data.file_index = h5read(file,'/file_index')';
%Retrieval level variables
data.xco2_raw = h5read(file,'/Retrieval/xco2_raw')';
data.surface_type = h5read(file,'/Retrieval/surface_type')';
data.psurf = h5read(file,'/Retrieval/psurf')';
data.psurf_apriori = h5read(file,'/Retrieval/psurf_apriori')';
data.h2o_scale = h5read(file,'/Retrieval/h2o_scale')';
%Most importantly for Eren, the TCWV:
data.tcwv = h5read(file, '/Retrieval/tcwv')';
data.tcwv_uncertainty = h5read(file, '/Retrieval/tcwv_uncertainty')';
data.tcwv_apriori = h5read(file, '/Retrieval/tcwv_apriori')';
% there are lots of other variables in Retrieval group that i'm not
% including here. AOD and albedo, for example. Temperature
%Sounding Group
data.altitude = h5read(file,'/Sounding/altitude')';
data.orbit = h5read(file,'/Sounding/orbit')';
data.path = h5read(file,'/Sounding/path')';
data.footprint = h5read(file,'/Sounding/footprint')';
data.land_water_indicator = h5read(file,'/Sounding/land_water_indicator')';
data.land_fraction = h5read(file,'/Sounding/land_fraction')';
data.l1b_type = h5read(file,'/Sounding/l1b_type')';
data.operation_mode = h5read(file,'/Sounding/operation_mode')';
data.airmass = h5read(file,'/Sounding/airmass')';
%get date info
date = h5read(file,'/date')'; %7 dimensions of date info, used to turn into datenum below
data.year = double(date(:,1))';
data.month = double(date(:,2))';
data.day = double(date(:,3))';
data.hour = double(date(:,4))';
data.minute = double(date(:,5))';
data.second = double(date(:,6))';

for i = 2:size(files,1)
    file = files(i,:);
    % Main Level Variables.
    data.time = [data.time h5read(file,'/time')']; % seconds since Jan 1, 1993: for above 559.420571E6.
    data.longitude = [data.longitude h5read(file,'/longitude')'];
    data.latitude = [data.latitude h5read(file,'/latitude')'];
    data.solar_zenith_angle = [data.solar_zenith_angle h5read(file,'/solar_zenith_angle')'];
    data.xco2 = [data.xco2 h5read(file,'/xco2')'];
    data.xco2_apriori = [data.xco2_apriori h5read(file,'/xco2_apriori')'];
    data.xco2_uncert = [data.xco2_uncert h5read(file,'/xco2_uncertainty')'];
    data.xco2_quality_flag = [data.xco2_quality_flag h5read(file,'/xco2_quality_flag')'];
    data.warn_level = [data.warn_level h5read(file,'/warn_level')'];
    data.sounding_id = [data.sounding_id h5read(file,'/sounding_id')'];
    data.source_files = [data.source_files h5read(file,'/source_files')'];
    data.file_index = [data.file_index h5read(file,'/file_index')'];
    %Retrieval level variables
    data.xco2_raw = [data.xco2_raw h5read(file,'/Retrieval/xco2_raw')'];
    data.surface_type = [data.surface_type h5read(file,'/Retrieval/surface_type')'];
    data.psurf = [data.psurf h5read(file,'/Retrieval/psurf')'];
    data.psurf_apriori = [data.psurf_apriori h5read(file,'/Retrieval/psurf_apriori')'];
    data.h2o_scale = [data.h2o_scale h5read(file,'/Retrieval/h2o_scale')'];
    
    %Most importantly for Eren, the TCWV:
    data.tcwv = [data.tcwv h5read(file, '/Retrieval/tcwv')'];
    data.tcwv_uncertainty = [data.tcwv_uncertainty  h5read(file, '/Retrieval/tcwv_uncertainty')'];
    data.tcwv_apriori = [data.tcwv_apriori h5read(file, '/Retrieval/tcwv_apriori')'];
    % there are lots of other variables in Retrieval group that i'm not
    % including here. AOD and albedo, for example. Temperature
    %Sounding Group
    data.altitude = [data.altitude h5read(file,'/Sounding/altitude')'];
    data.orbit = [data.orbit h5read(file,'/Sounding/orbit')'];
    data.path = [data.path h5read(file,'/Sounding/path')'];
    data.footprint = [data.footprint h5read(file,'/Sounding/footprint')'];
    data.land_water_indicator = [data.land_water_indicator h5read(file,'/Sounding/land_water_indicator')'];
    data.land_fraction = [data.land_fraction h5read(file,'/Sounding/land_fraction')'];
    data.l1b_type = [data.l1b_type h5read(file,'/Sounding/l1b_type')'];
    data.operation_mode = [data.operation_mode h5read(file,'/Sounding/operation_mode')'];
    data.airmass = [data.airmass h5read(file,'/Sounding/airmass')'];
    
    %get date info
    date = h5read(file,'/date')'; 
    data.year = [data.year double(date(:,1))'];
    data.month = [data.month double(date(:,2))'];
    data.day = [data.day double(date(:,3))'];
    data.hour = [data.hour double(date(:,4))'];
    data.minute = [data.minute double(date(:,5))'];
    data.second = [data.second double(date(:,6))'];

end

%do the datenum at the end after reading all data:
for j = 1:numel(data.year)
    data.datenum(j) = datenum(data.year(j),data.month(j),data.day(j),...
        data.hour(j),data.minute(j),data.second(j));
end

%save all the data, one file:
name2save = '/Users/stephanie/projects/cda/co2data/oco2/lite/B7305Br_MAT/OCO2_TPW_ALL.mat';
disp(['Saving ' name2save ' now at ' num2str(clock)])
save(name2save, 'data', '-mat');