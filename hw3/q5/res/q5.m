%s1
plot(YEAR, SSN);

%s2
X = SSN;
Xf=fft(X);
Xf(1)=[];
plot(abs(Xf));

%s3 freq 24(3153) period=11.0278
idx = find(abs(Xf) == max(abs(Xf)));
freq = min(idx);
period = length(Xf)/freq/12;

%s4 no frequency stands out
plot(Y);
Yf=fft(Y);
Yf(1)=[];
plot(abs(Yf));

%s5 freq 76(3101) stands out
plot(YM);
YMf=fft(YM);
YMf(1)=[];
plot(abs(YMf));
idx = find(abs(YMf) == max(abs(YMf)));

%s6
s = linspace(0,1,length(YM));
t = sin(2 * pi * min(idx) * s);
plot(0:length(YM)-1, t);
