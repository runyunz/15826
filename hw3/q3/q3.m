[U,S,V] = svd(X);

U3D = U(:,1:3);
S3D = S(1:3,1:3);
X3D = U3D * S3D;

plot(X3D(:,1),X3D(:,2), 'x');
plot(X3D(:,1),X3D(:,3), 'x');
plot(X3D(:,2),X3D(:,3), 'x');


[XICA] = fastica(transpose(X), 'numOfIC', 3);
XICA = transpose(XICA);

plot(XICA(:,1),XICA(:,2), 'x');
plot(XICA(:,1),XICA(:,3), 'x');
plot(XICA(:,2),XICA(:,3), 'x');

[nrow,ncol]=size(X);

sall = 0;
for i=1:nrow,
	if norm(X(i,:)) > 1,
		tmp = sort(abs(X3D(i,:)), 'descend');
		score = 1 - tmp(2)/tmp(1);
		fprintf('%d\t%d\n', i, score);
		sall = sall  + score;
	end
end
fprintf('sum(purity) for pca:\t%d\n', sall);


sall = 0;
for i=1:nrow,
	if norm(X(i,:)) > 1,
		tmp = sort(abs(XICA(i,:)), 'descend');
		score = 1 - tmp(2)/tmp(1);
		fprintf('%d\t%d\n', i, score);
		sall = sall  + score;
	end
end
fprintf('sum(purity) for ica:\t%d\n', sall);