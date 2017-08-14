function nothing = POP_Tcolor(ULONG,ULAT,var,levs)
% Generate color shaded surface plot for var on POP grid.
% POP_Tcolor(ULONG,ULAT,var)
%
% Generate color shaded surface plot.
% ULONG & ULAT are tracer cell corners of POP grid.
% var is the field to be plotted.
%
% It is assumed that masked values have been set to NaN.
%
% If hold is not set, POP_Tcolor will
%    1) clear axes (full reset)
%    2) set axes to [0 360 -80 90]
 
msg = nargchk(3,4,nargin);
if (~isempty(msg)) disp(msg); return; end;

[imt jmt] = size(ULONG);

%
% shift tracer data one index to the south & wast
% then boundaries of tracer cell i,j come from
% ULONG, ULAT at (i:i+1,j:j+1), which is more
% convenient for using matlab's pcolor command
%
var = POP_e_shift(POP_n_shift(var));

lcut = max(ULONG(imt,:));
rcut = min(ULONG(1,:));
cut = lcut-0.1*(rcut-lcut)-360;
ULONG(1:imt-5,:) = mod(ULONG(1:imt-5,:)-cut,360) + cut;

icut = min(find(abs(diff(ULONG(:,jmt)))>180));
jcut = max(find(abs(diff(ULONG(icut:icut+1,:)))<180));

PLOT_ULON = zeros([imt+2 jmt+3]);
PLOT_ULAT = zeros([imt+2 jmt+3]);
PLOT_VAR = zeros([imt+2 jmt+3]);

%
% generate plotting vertics for 1 <= j <= jcut
%

PLOT_ULON(1:icut,1:jcut) = ULONG(1:icut,1:jcut);
PLOT_ULAT(1:icut,1:jcut) = ULAT(1:icut,1:jcut);

PLOT_ULON(icut+1:imt+1,1:jcut) = ULONG(icut:imt,1:jcut);
PLOT_ULAT(icut+1:imt+1,1:jcut) = ULAT(icut:imt,1:jcut);

PLOT_ULON(imt+2,1:jcut) = ULONG(1,1:jcut)+360;
PLOT_ULAT(imt+2,1:jcut) = ULAT(1,1:jcut);

%
% generate first inserted North Pole row of plotting vertices
% coordinate indices j = jcut+1
%

PLOT_ULON(1:icut-1,jcut+1) = ULONG(1:icut-1,jcut);
PLOT_ULAT(1:icut-1,jcut+1) = ULAT(1:icut-1,jcut);

PLOT_ULON(icut,jcut+1) = ULONG(icut,jcut);
PLOT_ULAT(icut,jcut+1) = 90.0;

PLOT_ULON(icut+1,jcut+1) = ULONG(icut,jcut);
PLOT_ULAT(icut+1,jcut+1) = 90.0;

PLOT_ULON(icut+2:imt+1,jcut+1) = ULONG(icut+1:imt,jcut);
PLOT_ULAT(icut+2:imt+1,jcut+1) = ULAT(icut+1:imt,jcut);

PLOT_ULON(imt+2,jcut+1) = ULONG(1,jcut)+360;
PLOT_ULAT(imt+2,jcut+1) = ULAT(1,jcut);

%
% generate second inserted North Pole row of plotting vertices
% coordinate indices j = jcut+2
%

PLOT_ULON(1:icut-1,jcut+2) = ULONG(1:icut-1,jcut);
PLOT_ULAT(1:icut-1,jcut+2) = ULAT(1:icut-1,jcut);

PLOT_ULON(icut,jcut+2) = ULONG(icut,jcut+1);
PLOT_ULAT(icut,jcut+2) = 90.0;

PLOT_ULON(icut+1,jcut+2) = ULONG(icut,jcut+1)+360;
PLOT_ULAT(icut+1,jcut+2) = 90.0;

PLOT_ULON(icut+2:imt+1,jcut+2) = ULONG(icut+1:imt,jcut);
PLOT_ULAT(icut+2:imt+1,jcut+2) = ULAT(icut+1:imt,jcut);

PLOT_ULON(imt+2,jcut+2) = ULONG(1,jcut)+360;
PLOT_ULAT(imt+2,jcut+2) = ULAT(1,jcut);

%
% generate third inserted North Pole row of plotting vertices
% coordinate indices j = jcut+3
%

PLOT_ULON(1:icut-1,jcut+3) = ULONG(1:icut-1,jcut+1);
PLOT_ULAT(1:icut-1,jcut+3) = ULAT(1:icut-1,jcut+1);

PLOT_ULON(icut,jcut+3) = ULONG(icut,jcut+1);
PLOT_ULAT(icut,jcut+3) = 90.0;

PLOT_ULON(icut+1,jcut+3) = ULONG(icut,jcut+1)+360;
PLOT_ULAT(icut+1,jcut+3) = 90.0;

PLOT_ULON(icut+2:imt+1,jcut+3) = ULONG(icut+1:imt,jcut+1);
PLOT_ULAT(icut+2:imt+1,jcut+3) = ULAT(icut+1:imt,jcut+1);

PLOT_ULON(imt+2,jcut+3) = ULONG(1,jcut+1)+360;
PLOT_ULAT(imt+2,jcut+3) = ULAT(1,jcut+1);

%
% generate plotting vertices for jcut+4 <= j <= jmt
%

PLOT_ULON(1:icut,jcut+4:jmt+3) = ULONG(1:icut,jcut+1:jmt);
PLOT_ULAT(1:icut,jcut+4:jmt+3) = ULAT(1:icut,jcut+1:jmt);

PLOT_ULON(icut+1,jcut+4:jmt+3) = ULONG(icut,jcut+1:jmt)+360;
PLOT_ULAT(icut+1,jcut+4:jmt+3) = ULAT(icut,jcut+1:jmt);

PLOT_ULON(icut+2:imt+1,jcut+4:jmt+3) = ULONG(icut+1:imt,jcut+1:jmt);
PLOT_ULAT(icut+2:imt+1,jcut+4:jmt+3) = ULAT(icut+1:imt,jcut+1:jmt);

PLOT_ULON(imt+2,jcut+4:jmt+3) = ULONG(1,jcut+1:jmt)+360;
PLOT_ULAT(imt+2,jcut+4:jmt+3) = ULAT(1,jcut+1:jmt);

%
% generate padded version of VAR
%
PLOT_VAR = NaN + zeros(size(PLOT_ULON));
PLOT_VAR(icut,:) = NaN;
PLOT_VAR(imt+2,:) = NaN;
PLOT_VAR(:,jmt+2) = NaN;

PLOT_VAR(1:icut-1,1:jcut-1) = var(1:icut-1,1:jcut-1);
PLOT_VAR(icut+1:imt+1,1:jcut-1) = var(icut:imt,1:jcut-1);

PLOT_VAR(1:icut-1,jcut) = var(1:icut-1,jcut);
PLOT_VAR(icut+1:imt+1,jcut) = var(icut:imt,jcut);

PLOT_VAR(1:icut-1,jcut+1) = var(1:icut-1,jcut);
PLOT_VAR(icut+1:imt+1,jcut+1) = var(icut:imt,jcut);

PLOT_VAR(1:icut-1,jcut+2) = var(1:icut-1,jcut);
PLOT_VAR(icut+1:imt+1,jcut+2) = var(icut:imt,jcut);

PLOT_VAR(1:icut-1,jcut+3:jmt+2) = var(1:icut-1,jcut:jmt-1);
PLOT_VAR(icut+1:imt+1,jcut+3:jmt+2) = var(icut:imt,jcut:jmt-1);

NextPlot = get(gca,'NextPlot');

if (strcmp(NextPlot, 'replace'))
   cla reset;
   axis([0 360 -80 90]);
   hold on;
end;

if (nargin == 4)
   colormap(jet(length(levs)-1));
   tmp = zeros(size(PLOT_VAR));
   for l=1:length(levs),
      tmp = tmp + (PLOT_VAR >= levs(l));
   end;
   tmp(find(~isfinite(PLOT_VAR))) = NaN;
   PLOT_VAR = tmp;
   clear tmp;
end;

IRANGE = [1:icut];
h = pcolor(PLOT_ULON(IRANGE,:),PLOT_ULAT(IRANGE,:),PLOT_VAR(IRANGE,:));
if (nargin == 4) set(h,'CDataMapping','direct'); end;
h = pcolor(PLOT_ULON(IRANGE,:)+360,PLOT_ULAT(IRANGE,:),PLOT_VAR(IRANGE,:));
if (nargin == 4) set(h,'CDataMapping','direct'); end;

IRANGE = [icut+1:imt+2];
h = pcolor(PLOT_ULON(IRANGE,:)-360,PLOT_ULAT(IRANGE,:),PLOT_VAR(IRANGE,:));
if (nargin == 4) set(h,'CDataMapping','direct'); end;
h = pcolor(PLOT_ULON(IRANGE,:),PLOT_ULAT(IRANGE,:),PLOT_VAR(IRANGE,:));
if (nargin == 4) set(h,'CDataMapping','direct'); end;

shading flat;

if (strcmp(NextPlot, 'replace'))
   hold off;
end;

