function none = overlay_coastlines();
% overlay contintental coastlines on a figure

% load coastal dataset
coast = load('coast');

hold on;
plot(coast.long, coast.lat, 'k', 'Linewidth', 2);
plot(coast.long+360, coast.lat, 'k', 'Linewidth', 2);
hold off;
