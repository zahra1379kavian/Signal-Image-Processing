close all
clc
clear

load('X_org'); load('Electrodes'); load('X_noise');
%% part 1 /// Plot Orginal Sinal
titl = 'Original Signal';
ElecName = Electrodes.labels;
plotEEG(X_org,titl,ElecName)
%% part 2 /// Plot Noisy Signal
titl = 'Noisy Signal';
plotEEG(X_noise,titl,ElecName)

%% part 3 /// Add Noise With Different SNR

SNR = -15; % SNR = [5,15]
Ps = sum(X_org.^2,'all');
PN = sum(X_noise.^2,'all');
std = Ps/PN*10^(-SNR/10);

X_noisy = X_org + sqrt(std).*X_noise;

titl = "Noisy Signal with SNR = "+ num2str(SNR);
plotEEG(X_noisy,titl,ElecName)
%% part 4 /// ICA

Pest = 32;
[F,W,K] = COM2R(X_noisy,Pest);
Source_ICA = W*X_noisy;

My_sourceName = {'S1','S2','S3','S4','S5','S6','S7','S8','S9','S10','S11','S12','S13','S14',...
    'S15','S16','S17','S18','S19','S20','S21','S22','S23','S24','S25','S26','S27','S28',...
    'S29','S30','S31','S32'};
titl = "Noisy Signal with SNR = "+ num2str(SNR)+" After ICA";
plotEEG(Source_ICA,titl,My_sourceName)
%% Select Source and Reconstruct Signal
%Source_selected = [2,5,9,12,21,23]; %SNR=-5
Source_selected = [7,8,9,15,18,19,20,30]; %SNR=-15
source_select = Source_ICA(Source_selected,:);
x_den = F(:,Source_selected)*source_select;
titl = "Reconstruct Signal with SNR = "+ num2str(SNR);
plotEEG(x_den,titl,ElecName)
%% plot channel 13,24
ch = 13;
figure
subplot(3,1,1)
plot(X_org(ch,:))
title('Orginal Signal')
grid('on')
ylabel(['Channel ',num2str(ch)]);

subplot(3,1,2)
plot(X_noisy(ch,:))
title(['Noisy Signal5 with SNR = ',num2str(SNR)])
grid('on')
ylabel(['Channel ',num2str(ch)]);

subplot(3,1,3)
plot(x_den(ch,:))
title('Reconstructed Signal')
grid('on')
ylabel(['Channel ',num2str(ch)]);
%% RRMSE
rrmse_ICA = sqrt(sum((X_org-x_den).^2,'all'))./sqrt(sum(X_org.^2,'all'))
