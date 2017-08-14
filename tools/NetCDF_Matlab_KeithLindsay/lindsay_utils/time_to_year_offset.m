function out_time = time_to_year_offset(in_time, units, calendar)
% convert time value to years of offset
% time_to_year_offset(in_time, units, calendar)

valid_calendar = {'noleap', '365_day', 'julian'};

if ~any(strcmp(calendar, valid_calendar))
    disp([calendar 'not a supported calendar, no conversion']);
    out_time = in_time;
    return
end;

day_valid  = {'day', 'days'};
hour_valid = {'hour', 'hours'};
min_valid  = {'minute', 'minutes'};
sec_valid  = {'sec', 'secs', 'second', 'seconds'};

if any(strcmp(calendar, {'noleap', '365_day'}))
    for ind = 1:length(day_valid),
        if (strfind(units, [day_valid{ind} ' since']) == 1)
            out_time = in_time / 365;
            return;
        end;
    end;
    for ind = 1:length(hour_valid),
        if (strfind(units, [hour_valid{ind} ' since']) == 1)
            out_time = in_time / (365 * 24);
            return;
        end;
    end;
    for ind = 1:length(min_valid),
        if (strfind(units, [min_valid{ind} ' since']) == 1)
            out_time = in_time / (365 * 24 * 60);
            return;
        end;
    end;
    for ind = 1:length(sec_valid),
        if (strfind(units, [sec_valid{ind} ' since']) == 1)
            out_time = in_time / (365 * 24 * 60 * 60);
            return;
        end;
    end;
end;

if strcmp(calendar, 'julian')
    for ind = 1:length(day_valid),
        if (strfind(units, [day_valid{ind} ' since']) == 1)
            out_time = in_time / 365.25;
            return;
        end;
    end;
    for ind = 1:length(hour_valid),
        if (strfind(units, [hour_valid{ind} ' since']) == 1)
            out_time = in_time / (365.25 * 24);
            return;
        end;
    end;
    for ind = 1:length(min_valid),
        if (strfind(units, [min_valid{ind} ' since']) == 1)
            out_time = in_time / (365.25 * 24 * 60);
            return;
        end;
    end;
    for ind = 1:length(sec_valid),
        if (strfind(units, [sec_valid{ind} ' since']) == 1)
            out_time = in_time / (365.25 * 24 * 60 * 60);
            return;
        end;
    end;
end;
