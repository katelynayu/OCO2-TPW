function res = comp_masked_weighted_mean(field, mask, area)
% compute masked weighted mean of a variable
% comp_masked_weighted_mean(field, mask, area)
%
% field can have at most 4 dimensions
%
% mask & area are assumed to be 2 dimensional and have
% the dimensions of the leading dimensions of field

ind = find(mask);
weight_flat = area(ind);
weight_flat = weight_flat / sum(weight_flat);

field_size = size(field);

if (length(field_size) == 2)
    res = sum(field(ind) .* weight_flat);
    return;
end;

if (length(field_size) == 3)
    res = zeros([field_size(3) 1]);
    for ind3 = 1:field_size(3)
        field_slice = field(:,:,ind3);
        res(ind3) = sum(field_slice(ind) .* weight_flat);
    end;
    return;
end;

if (length(field_size) == 4)
    res = zeros(field_size(3:4));
    for ind4 = 1:field_size(4)
        for ind3 = 1:field_size(3)
            field_slice = field(:,:,ind3,ind4);
            res(ind3,ind4) = sum(field_slice(ind) .* weight_flat);
        end;
    end
    return;
end;
