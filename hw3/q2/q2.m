[U,S,V] = svd(X, 0);

U2D = U(:,1:2);
S2D = S(1:2,1:2);
V2D = V(:,1:2);

X2D = U2D * S2D;
plot(X2D(:,1),X2D(:,2), 'x');

X5D = X2D * transpose(V2D);
