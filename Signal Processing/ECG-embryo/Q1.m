%% Ali Shahbazi - Zahra Kavian - MohammadReza Safavi
%% Lab3 - Q1
clc; clear; close all;

load('./data/mecg1.dat');
load('./data/fecg1.dat');
load('./data/noise1.dat');
Fs = 256;
t = 0:1/Fs:(length(mecg1)-1)/Fs;

%% Part 1
all_signals_1 = fecg1 + mecg1 + noise1;

%% 1
figure;
subplot(2,2,1);
plot(t, mecg1, 'linewidth', 1.5);
myPlotProp([], [-8 8], 'Mother ECG', 'Time ($s$)', 'Voltage ($mV$)', 'off', '', 12);
subplot(2,2,2);
plot(t, fecg1, 'linewidth', 1.5);
myPlotProp([], [-8 8], 'Infant ECG', 'Time ($s$)', 'Voltage ($mV$)', 'off', '', 12);
subplot(2,2,3);
plot(t, noise1, 'linewidth', 1.5);
myPlotProp([], [-8 8], 'Noise', 'Time ($s$)', 'Voltage ($mV$)', 'off', '', 12);
subplot(2,2,4);
plot(t, all_signals_1, 'linewidth', 1.5);
myPlotProp([], [-8 8], 'Recorded ECG', 'Time ($s$)', 'Voltage ($mV$)', 'off', '', 12);

%% 2
[pxx1, ~] = pwelch(mecg1, [], [], [], Fs);
[pxx2, ~] = pwelch(fecg1, [], [], [], Fs);
[pxx3, f] = pwelch(noise1, [], [], [], Fs);

%%
figure;
subplot(2,2,1);
plot(f, 10*log10(pxx1), 'linewidth', 1.5);
myPlotProp([0 Fs/2], [-80 0], 'Mother ECG Power Spectrum', 'Frequency (Hz)', 'Power/Freq (dB/Hz)', 'off', '', 12);
subplot(2,2,2);
plot(f, 10*log10(pxx2), 'linewidth', 1.5);
myPlotProp([0 Fs/2], [-80 0], 'Infant ECG Power Spectrum', 'Frequency (Hz)', 'Power/Freq (dB/Hz)', 'off', '', 12);
subplot(2,2,3);
plot(f, 10*log10(pxx3), 'linewidth', 1.5);
myPlotProp([0 Fs/2], [-80 0], 'Noise Power Spectrum', 'Frequency (Hz)', 'Power/Freq (dB/Hz)', 'off', '', 12);

%% 3
mean_m = mean(mecg1)
mean_f = mean(fecg1)
mean_noise = mean(noise1)
var_m = var(mecg1)
var_f = var(fecg1)
var_noise = var(noise1)

%% 4
figure;
subplot(2,2,1);
histogram(mecg1);
subplot(2,2,2);
histogram(fecg1);
subplot(2,2,3);
histogram(noise1);

kurtosis_m = kurtosis(mecg1)
kurtosis_f = kurtosis(fecg1)
kurtosis_noise = kurtosis(noise1)








