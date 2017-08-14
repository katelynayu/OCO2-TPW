function dst = POP_n_shift(src)
% shift from north
% POP_n_shift(src)

[imt jmt] = size(src);
dst = zeros([imt jmt]);
dst(:,1:jmt-1) = src(:,2:jmt);
dst(:,jmt) = src(:,1);
