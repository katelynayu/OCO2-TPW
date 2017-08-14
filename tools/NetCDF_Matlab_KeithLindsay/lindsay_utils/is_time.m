function res = is_time(units)
% Does units represent valid udunits time?
% is_time(units)

valid = {'day', 'days', 'hour', 'hours', 'minute', 'minutes', 'sec', 'secs', 'second', 'seconds'};

for ind = 1:length(valid),
    if (strfind(units, [valid{ind} ' since']) == 1)
        res = 1;
        return;
    end;
end;

res = 0;
