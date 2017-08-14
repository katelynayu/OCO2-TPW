function [c1, h1, c2, h2, c3, h3] = POP_Tcontour(TLONG,TLAT,VAR,levs)
% Generate contour plot for var on POP grid.
% POP_Tcontour(TLONG,TLAT,var)
%
% Generate contour plot.
% TLONG & TLAT are tracer cell centers of POP grid.
% var is the field to be plotted.
% levs (optional) are contour levels to be plotted.
%
% It is assumed that masked values have been set to NaN.
%
% If hold is not set, POP_Tcontour will
%    1) clear axes (full reset)
%    2) set axes to [0 360 -80 90]
 
msg = nargchk(3,4,nargin);
if (~isempty(msg)) disp(msg); return; end;

[imt jmt] = size(TLONG);

cut = (TLONG(1,jmt) + TLONG(imt,jmt))/2 - 360 + 0.1;
TLONG = mod(TLONG-cut,360) + cut;
icut = min(find(abs(diff(TLONG(:,jmt)))>180));
jcut = 1+max(find(abs(diff(TLONG(icut:icut+1,:)))<180));

PLOT_TLONG = zeros([imt+4 jmt]);
PLOT_TLAT = zeros([imt+4 jmt]);
PLOT_VAR = zeros([imt+4 jmt]);

PLOT_TLONG(1:icut,:) = TLONG(1:icut,:);
PLOT_TLAT(1:icut,:) = TLAT(1:icut,:);
PLOT_VAR(1:icut,:) = VAR(1:icut,:);

PLOT_TLONG(icut+1,1:jcut-1) = TLONG(icut+1,1:jcut-1);
PLOT_TLONG(icut+1,jcut:jmt) = TLONG(icut+1,jcut:jmt)-360;
PLOT_TLAT(icut+1,:) = TLAT(icut+1,:);
PLOT_VAR(icut+1,:) = VAR(icut+1,:);

PLOT_TLONG(icut+2,1:jcut-1) = TLONG(icut+1,1:jcut-1);
PLOT_TLONG(icut+2,jcut:jmt) = TLONG(icut+1,jcut:jmt)-360;
PLOT_TLAT(icut+2,:) = TLAT(icut+1,:);
PLOT_VAR(icut+2,:) = NaN;

PLOT_TLONG(icut+3,1:jcut-1) = TLONG(icut,1:jcut-1);
PLOT_TLONG(icut+3,jcut:jmt) = TLONG(icut,jcut:jmt)+360;
PLOT_TLAT(icut+3,:) = TLAT(icut,:);
PLOT_VAR(icut+3,:) = VAR(icut,:);

PLOT_TLONG(icut+4:imt+3,:) = TLONG(icut+1:imt,:);
PLOT_TLAT(icut+4:imt+3,:) = TLAT(icut+1:imt,:);
PLOT_VAR(icut+4:imt+3,:) = VAR(icut+1:imt,:);

PLOT_TLONG(imt+4,1:jcut-1) = TLONG(1,1:jcut-1);
PLOT_TLONG(imt+4,jcut:jmt) = TLONG(1,jcut:jmt)+360;
PLOT_TLONG(imt+4,:) = TLONG(1,:)+360;
PLOT_TLAT(imt+4,:) = TLAT(1,:);
PLOT_VAR(imt+4,:) = VAR(1,:);

NextPlot = get(gca,'NextPlot');

if (strcmp(NextPlot, 'replace'))
   cla reset;
   axis([0 360 -80 90]);
   hold on;
end;

if (nargin == 4)
   [c1,h1] = contour(PLOT_TLONG(:,2:jmt),PLOT_TLAT(:,2:jmt),PLOT_VAR(:,2:jmt),levs,'k-');
   [c2,h2] = contour(PLOT_TLONG(:,2:jmt)-360,PLOT_TLAT(:,2:jmt),PLOT_VAR(:,2:jmt),levs,'k-');
   [c3,h3] = contour(PLOT_TLONG(:,2:jmt)+360,PLOT_TLAT(:,2:jmt),PLOT_VAR(:,2:jmt),levs,'k-');
else
   [c1,h1] = contour(PLOT_TLONG(:,2:jmt),PLOT_TLAT(:,2:jmt),PLOT_VAR(:,2:jmt),'k-');
   [c2,h2] = contour(PLOT_TLONG(:,2:jmt)-360,PLOT_TLAT(:,2:jmt),PLOT_VAR(:,2:jmt),'k-');
   [c3,h3] = contour(PLOT_TLONG(:,2:jmt)+360,PLOT_TLAT(:,2:jmt),PLOT_VAR(:,2:jmt),'k-');
end;

if (strcmp(NextPlot, 'replace'))
   hold off;
end;

