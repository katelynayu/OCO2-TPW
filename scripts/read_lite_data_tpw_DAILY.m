% This one reads the daily lite files and saves them as daily mat files

onefile = '../data/B7305Br/oco2_LtCO2_170101_B7305Br_170223010226s.nc4';

%note, to learn what is in this one file, you can use h5info, and h5disp:
foo = h5info(onefile);
foo.Groups.Name % to see the group names in this file
h5disp(onefile, '/Retrieval/tcwv') % gives you some idea of the tcwv variable (units, etc.)

% datadir is wherever you have your Lite files stored
% Stephanie has Jan 1 2017 through Feb 8 data in this directory:
datadir = '../data/B7305Br/';
addpath(datadir)
savedir = '../data/B7305-MAT/';

% Get a list of all the files you want to read in in a particular directory
files = {}; flist = [];
filecount = 0; filecount2 = 0;
bad_file_inds2 = NaN;
filenames = dir([datadir 'oco2_LtCO2*nc4']);
for i = 1:numel(filenames)
    files{i} = filenames(i).name;
end
files = char(files);

for i = 1:size(files,1)
    file = files(i,:);
    %extract date information from the filename being read in:
    %dateinfo = file(length(datadir)+12:length(datadir)+17);
    dateinfo = file(12:17);
    name2save = [savedir 'OCO2_' dateinfo '.mat'];
    if exist(name2save,'file') == 2
        disp(['Already processed ' name2save ' skipping...' ]);
        continue;
    else
        disp(['Processing ' file ' now at ' num2str(clock)])
    end
    
    %save variables in struct called 'data'
    data = {};
    
    %some files are empty / don't work
    try
        % Main Level Variables.
        data.time = h5read(file,'/time')'; % seconds since Jan 1, 1993: for above 559.420571E6.
        data.date = h5read(file,'/date')'; %
        data.longitude = h5read(file,'/longitude')';
        data.latitude = h5read(file,'/latitude')';
        data.solar_zenith_angle = h5read(file,'/solar_zenith_angle')';
        data.xco2 = h5read(file,'/xco2')';
        data.xco2_apriori = h5read(file,'/xco2_apriori')';
        data.xco2_uncert = h5read(file,'/xco2_uncertainty')';
        data.xco2_quality_flag = h5read(file,'/xco2_quality_flag')';
        data.warn_level = h5read(file,'/warn_level')';
        data.co2_profile_apriori = h5read(file,'/co2_profile_apriori')';
        data.xco2_averaging_kernel = h5read(file,'/xco2_averaging_kernel')';
        data.pressure_levels = h5read(file,'/pressure_levels')';
        data.pressure_weight = h5read(file,'/pressure_weight')';
        data.sounding_id = h5read(file,'/sounding_id')';
        data.source_files = h5read(file,'/source_files')';
        data.file_index = h5read(file,'/file_index')';
        %Retrieval level variables
        data.xco2_raw = h5read(file,'/Retrieval/xco2_raw')';
        data.surface_type = h5read(file,'/Retrieval/surface_type')';
        data.psurf = h5read(file,'/Retrieval/psurf')';
        data.psurf_apriori = h5read(file,'/Retrieval/psurf_apriori')';
        data.dp = h5read(file,'/Retrieval/dp')';
        data.h2o_scale = h5read(file,'/Retrieval/h2o_scale')';
        data.windspeed = h5read(file,'/Retrieval/windspeed')';
        data.windspeed_apriori = h5read(file,'/Retrieval/windspeed_apriori')';
        
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
        data.year = double(data.date(:,1))';
        data.month = double(data.date(:,2))';
        data.day = double(data.date(:,3))';
        data.hour = double(data.date(:,4))';
        data.minute = double(data.date(:,5))';
        data.second = double(data.date(:,6))';
        for j = 1:numel(data.year)
            data.datenum(j) = datenum(data.year(j),data.month(j),data.day(j),...
                data.hour(j),data.minute(j),data.second(j));
        end
        
        disp(['Saving ' name2save ' now at ' num2str(clock)])
        save(name2save, 'data', '-mat');
    catch
        filecount2 = filecount2 + 1;
        bad_file_inds2(filecount2) = i;
        disp(['Cant read data from file ' file])
        disp(['Moving on to next file'])
    end
end