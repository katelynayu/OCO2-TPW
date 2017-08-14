function dst = POP_e_shift(src)
% shift from east
% POP_e_shift(src)

[imt jmt] = size(src);
dst = zeros([imt jmt]);
dst(1:imt-1,:) = src(2:imt,:);
dst(imt,:) = src(1,:);
