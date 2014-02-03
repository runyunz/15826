%Part A
%s1 not able to detect any major periodicities
plot(Y);
Yf=fft(Y);
Yf(1)=[];
plot(abs(Yf));
%s2 
wavelet_scaleogram(transpose(Y), 12);
%s3 t=[1025:1536]; freq = 4

%Part B
%s1
sum1 = sum(Y(512:1024)); %2.6350e+03
%s2
[C,L]=wavedec(Y, 7,'haar');
[val,idx] = sort(abs(C), 'descend');
idx = idx(1:100);
Cs = zeros(length(C),1);
Cs(idx) = C(idx);
Yr=waverec(Cs,L,'haar');
sum2 = sum(Yr(512:1024)); %2.6382e+03
err1 = abs(sum2 - sum1);  %3.2241
%s3
pos_s = [5:8];
pos = 4;
for i=1:length(L)-2,
	new_s = [1:2^(i+1)]+pos+sum(L(1:i));
	pos=pos + 2^(i+1);
	pos_s = cat(2, pos_s, new_s);
end
pos_s = transpose(pos_s);
points = intersect(idx, pos_s);
Css = zeros(length(C),1);
Css(points) = C(points);
Yrr=waverec(Css,L,'haar');
sum3 = sum(Yrr(512:1024)) %2.6336e+03
err2 = abs(sum3 - sum1);  %1.4266
