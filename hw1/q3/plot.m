% Runyun Zhang - 15826 Fall 2013

zorder = load("zorder_data");
plot(zorder(:,1), zorder(:,2));
axis([0, 127, 0, 127]);
print -dpng 'zorder.png';

horder = load("horder_data");
plot(horder(:,1), horder(:,2));
axis([0, 127, 0, 127]);
print -dpng 'horder.png';

