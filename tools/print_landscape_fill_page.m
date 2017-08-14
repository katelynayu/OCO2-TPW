function print_landscape_fill_page(h,name2save)
    %h = figure(2); 
    set(h,'PaperOrientation','landscape');
    paperUnits = get(h, 'PaperUnits');
    set(h,'PaperUnits','inches');
    paperSize = get(h,'PaperSize');
    paperPosition = [.5 .5 paperSize - .5];
    set(h,'PaperPosition', paperPosition);
    set(h,'PaperUnits',paperUnits);
    print(h, '-dpng',name2save)
end