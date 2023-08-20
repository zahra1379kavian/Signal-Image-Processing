% close all
 clc
% clear
% Q3

% part 3
mecg= load('mecg1.dat');
fecg= load('fecg1.dat');
noise= load('noise1.dat');

%%
X= load('X.dat');
%%
% ICA
[W, Zhat] = ica(X');
A= W';
%%
% plot Main Data
Fs= 256; plot_title= 'Main Data';
plot3ch(X,Fs,plot_title);

% plot the weight vector
hold on
for i= 1:3
    plot3dv(A(:,i))
    hold on
end


%%
% plot the sources
subplot(3,1,1)
plot(Zhat(1,:))
subplot(3,1,2)
plot(Zhat(2,:))
subplot(3,1,3)
plot(Zhat(3,:))

%%
% Keep only the best source
Ap= A;
Ap(:,1:2)= 0;

% Reconstruct Signal
Xp= Ap*Zhat;
Xpz= zscore(Xp');
plot_title= 'Reconstructed Data';
plot3ch(Xpz,Fs,plot_title);

%%
% RRMSE error
X_org= fecg; x_den= Xpz(:,1);
rrmse_ICA = sqrt(sum((X_org-x_den).^2,'all'))./sqrt(sum(X_org.^2,'all'))


