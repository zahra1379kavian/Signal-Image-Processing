%% Lab 3 - Q2
close all; clear; clc;

%% Part 1

X = load('./data/X.dat');
plot3ch(X);

[U,S,V] = svd(X);
xlim([-15,15]);   
ylim([-15,15]);
zlim([-15,15]);

%% Part 2
for i=1:3
    plot3dv(V(:,i), S(i,i));
end

save('Q2_U.mat', 'U');
save('Q2_S.mat', 'S');
save('Q2_V.mat', 'V');

%% Part 3
figure;
for i=1:3
    subplot(3,1,i);
    plot(U(:,i));
end
figure
stem([S(1,1),S(2,2),S(3,3)])
title('eigenspectrum');

%% Part 4
newS = zeros(size(S));
newS(2,2) = S(2,2);
new = U*newS*V';
plot3ch(new);
fecg1 = load('./data/fecg1.dat');

rrmse_ICA_1 = sqrt(sum((fecg1-new(:,1)).^2,'all'))./sqrt(sum(fecg1.^2,'all'));
rrmse_ICA_2 = sqrt(sum((fecg1-new(:,2)).^2,'all'))./sqrt(sum(fecg1.^2,'all'));
rrmse_ICA_3 = sqrt(sum((fecg1-new(:,3)).^2,'all'))./sqrt(sum(fecg1.^2,'all'));

