%q2
tensor=dlmread('tensor.dat','\t')
T = sptensor(tensor(:,1:3), tensor(:,4));

%q3 - component #1 contains the bipartite core
D = cp_als(T, 2);
U1 = D.U{1};
U2 = D.U{2};
U3 = D.U{3};
plot(U1(:,1)); 
plot(U2(:,1)); 
plot(U3(:,1)); 
plot(U1(:,2)); 
plot(U2(:,2)); 
plot(U3(:,2)); 

%q4
u1 = U1(:,1);
u1_idx = find(abs(u1-0.35)<0.01); % user(8): 1 2 3 5 7 8 9 10

u2 = U2(:,1);
u1_idx = find(abs(u1-0.50)<0.01); % page(4): 11 12 13 14

u3 = U3(:,1);
u3_idx = find(abs(u3-0.50)<0.01); % date(4): 11 12 15 16


