%% Q4
clc; clear; close all;
X = load('./data/X.dat');
load('A_ICA.mat');
load('X_den_ICA.mat');
load('X_den_SVD.mat');
load('V_SVD.mat');
load('Q2_S.mat');
load('./data/fecg1.dat');
load('./data/fecg2.dat');

%% 1 - a
figure;
subplot(2,2,1);
my_plot3ch(X);

subplot(2,2,2);
my_plot3ch(new); hold on;
for i=1:3
    plot3dv(V(:,i), S(i,i));
end

subplot(2,2,3);
my_plot3ch(Xp'); hold on;
for i=1:3
    plot3dv(A(:, i));
end

%% 1 - b
diff_angle_SVD = acosd(V'*V)
A_norm(:,1) = A(:,1)/norm(A(:,1));
A_norm(:,2) = A(:,2)/norm(A(:,2));
A_norm(:,3) = A(:,3)/norm(A(:,3));
diff_angle_ICA = acosd(A_norm'*A_norm)

figure;
stem([norm(V(:,1)), norm(V(:,2)), norm(V(:,3))]);
figure;
stem([norm(A(:,1)), norm(A(:,2)), norm(A(:,3))]);

%% 2
Fs = 256;
t = 0:1/Fs:(size(X,1)-1)/Fs;
figure;
plot(t, zscore(Xp(1,:)')'); hold on;
plot(t, fecg1); title('ICA');

figure;
plot(t, new(:,3)); hold on;
plot(t, fecg2); title('SVD');

%% 3
corr_ICA = corrcoef(fecg1, zscore(Xp(1,:)')')
corr_SVD = corrcoef(fecg2, new(:,3))


