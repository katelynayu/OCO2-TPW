function [c1, h1, c2, h2, c3, h3] = POP_Tcontourf(TLONG,TLAT,VAR,levs)
% Generate filled contour plot for var on POP grid.
% POP_Tcontourf(TLONG,TLAT,var)
%
% Generate filled contour plot.
% TLONG & TLAT are tracer cell centers of POP grid.
% var is the field to be plotted.
% levs (optional) are contour levels to be plotted.
%
% It is assumed that masked values have been set to NaN.
%
% If hold is not set, POP_Tcontourf will
%    1) clear axes (full reset)
%    2) set axes to [0 360 -80 90]
 
msg = nargchk(3,4,nargin);
if (~isempty(msg)) disp(msg); return; end;

NextPlot = get(gca,'NextPlot');

if (strcmp(NextPlot, 'replace'))
   cla reset;
   axis([0 360 -80 90]);
   hold on;
end;

if (nargin == 4)
    POP_Tcolor(TLONG,TLAT,VAR,levs);
    [c1, h1, c2, h2, c3, h3] = POP_Tcontour(TLONG,TLAT,VAR,levs);
else
    POP_Tcolor(TLONG,TLAT,VAR);
    [c1, h1, c2, h2, c3, h3] = POP_Tcontour(TLONG,TLAT,VAR);
end;

if (strcmp(NextPlot, 'replace'))
   hold off;
end;
