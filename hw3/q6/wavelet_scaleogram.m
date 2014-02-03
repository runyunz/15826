function cfd = wavelet_scaleogram(y,L)
%Produces the Haar wavelet scaleogram of signal 'y', for 'L' levels

len = length(y);
[coefs,longs] = wavedec(y,L,'haar');
% Expand discrete wavelet coefficients for plot.
% Levels 1 to 5 correspond to scales 2, 4, 8, 16 and 32.
cfd = zeros(L,len);
for k = 1:L
    d = detcoef(coefs,longs,k);
    d = d(ones(1,2^k),:);
    cfd(k,:) = wkeep(d(:)',len);
end

cfd = cfd(:);

I = find(abs(cfd)<sqrt(eps));
cfd(I)=zeros(size(I));
cfd = reshape(cfd,L,len);

%T = flipud(wcodemat(cfd, 64, 'row'));
T = flipud(abs(cfd));
size(T)
figure
subplot(2,1,2);
imagesc(T);colormap(jet);colorbar;
subplot(2,1,1)
plot(y)