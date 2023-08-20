%%%%%%%% Lab1 %%%%%%%%%%%
%%%%%%% Ali Shahbazi, Zahra Kavian, Mohammadreza Safavi %%%%%%
close all; clear; clc;

%% Part 1: EEG

%% load data
close all; clear; clc;
EEG_sig = load('EEG_sig.mat');
des = EEG_sig.des;
Fs = des.samplingfreq;
channelnames = des.channelnames;
nbsamples = des.nbsamples;
t = 0:1/Fs:nbsamples/Fs-1/Fs;

%% 1-1
close all;
ch5 = EEG_sig.Z(5,:);
figure
plot(t, ch5);
myPlotProp('auto', 'auto', channelnames{5}+" channel", 'Time ($s$)', 'Voltage', 'off', 14)

%% 1-2
close all;
fontsize = 12;
y_lim = [min(ch5), max(ch5)];
figure;
subplot(2,2,1);
plot(t(1:15*Fs), ch5(1:15*Fs));
myPlotProp([0, 15], y_lim, 'EEG from 0 to 15 s', 'time(s)', '', 'off', fontsize)

subplot(2,2,2);
plot(t(18*Fs:40*Fs), ch5(18*Fs:40*Fs));
myPlotProp([18, 40], y_lim, 'EEG from 18 to 40 s', 'time(s)', '', 'off', fontsize)

subplot(2,2,3);
plot(t(45*Fs:50*Fs), ch5(45*Fs:50*Fs));
myPlotProp([45, 50], y_lim, 'EEG from 45 to 50 s', 'time(s)', '', 'off', fontsize)

subplot(2,2,4);
plot(t(50*Fs:end), ch5(50*Fs:end));
myPlotProp([50, 64], y_lim, 'EEG from 50 to 64 s', 'time(s)', '', 'off', fontsize)

%% 1-3
close all;
ch3 = EEG_sig.Z(3,:);
x_lim = [0, 64];
y_lim = [min(min(ch5),min(ch3)), max(max(ch5),max(ch3))];

figure
subplot(1,2,1);
plot(t, ch5);
myPlotProp(x_lim, y_lim, channelnames{5}+" channel", 'Time ($s$)', 'Channel 5', 'off', 14)

subplot(1,2,2);
plot(t, ch3);
myPlotProp(x_lim, y_lim, channelnames{3}+" channel", 'Time ($s$)', 'Channel 3', 'off', 14)

%% 1-4
close all;
Z = EEG_sig.Z;
offset = max(max(abs(Z)))/2;

disp_eeg(Z, offset, Fs, channelnames);

%% 1-5
%%%% In the report

%% 1-6
close all;
my_ylim = [-40, 60];
my_xlabel = 'time(s)';
my_ylabel = 'Amplitude';
I1 = ch5(2*Fs:7*Fs);
I2 = ch5(30*Fs:35*Fs);
I3 = ch5(42*Fs:47*Fs);
I4 = ch5(50*Fs:55*Fs);

[fftI1, fI1] = my_fft(I1, Fs);
[fftI2, fI2] = my_fft(I2, Fs);
[fftI3, fI3] = my_fft(I3, Fs);
[fftI4, fI4] = my_fft(I4, Fs);

figure
subplot(4,2,1);
plot(t(2*Fs:7*Fs), I1);
myPlotProp([2, 7], my_ylim, 'Time domain for interval 1', my_xlabel, my_ylabel, 'off', fontsize)

subplot(4,2,2);
plot(fI1, fftI1);
myPlotProp([0,60], 'auto', 'Freq domain for interval 1', 'f(Hz)', my_ylabel, 'off', fontsize)

subplot(4,2,3);
plot(t(30*Fs:35*Fs), I2);
myPlotProp([30, 35], my_ylim, 'Time domain for interval 2', my_xlabel, my_ylabel, 'off', fontsize)

subplot(4,2,4);
plot(fI2, fftI2);
myPlotProp([0,60], 'auto', 'Freq domain for interval 2', 'f(Hz)', my_ylabel, 'off', fontsize)

subplot(4,2,5);
plot(t(42*Fs:47*Fs), I3);
myPlotProp([42, 47], my_ylim, 'Time domain for interval 3', my_xlabel, my_ylabel, 'off', fontsize)

subplot(4,2,6);
plot(fI3, fftI3);
myPlotProp([0,60], 'auto', 'Freq domain for interval 3', 'f(Hz)', my_ylabel, 'off', fontsize)

subplot(4,2,7);
plot(t(50*Fs:55*Fs), I4);
myPlotProp([50, 55], my_ylim, 'Time domain for interval 4', my_xlabel, my_ylabel, 'off', fontsize)

subplot(4,2,8);
plot(fI4, fftI4);
myPlotProp([0,60], 'auto', 'Freq domain for interval 4', 'f(Hz)', my_ylabel, 'off', fontsize)

%% 1-7
close all;

I1 = ch5(2*Fs:7*Fs);
I2 = ch5(30*Fs:35*Fs);
I3 = ch5(42*Fs:47*Fs);
I4 = ch5(50*Fs:55*Fs);

window = hamming(128);
noverlap = 64;
nfft = 128;
figure
subplot(4,1,1);
pwelch(I1,window,noverlap,nfft, Fs);
xlim([0, 60]);
ylabel('Interval 1 (Power/freq) (dB/Hz)');

subplot(4,1,2);
pwelch(I2,window,noverlap,nfft, Fs);
xlim([0, 60]);
ylabel('Interval 2 (Power/freq) (dB/Hz)');

subplot(4,1,3);
pwelch(I3,window,noverlap,nfft, Fs);
xlim([0, 60]);
ylabel('Interval 3 (Power/freq) (dB/Hz)');

subplot(4,1,4);
pwelch(I4,window,noverlap,nfft, Fs);
xlim([0, 60]);
ylabel('Interval 4 (Power/freq) (dB/Hz)');

%% 1-8
close all;
my_xlabel = 'f(Hz)';
my_ylabel = 'Amplitude';
I1 = ch5(2*Fs:7*Fs);
I2 = ch5(30*Fs:35*Fs);
I3 = ch5(42*Fs:47*Fs);
I4 = ch5(50*Fs:55*Fs);

window = hamming(128);
noverlap = 64;
nfft = 128;

figure
subplot(4,1,1);
spectrogram(I1,window,noverlap,nfft, Fs, 'yaxis')
ylim([0, 60]);
ylabel('Interval 1 (Frequency (Hz))');

subplot(4,1,2);
spectrogram(I2,window,noverlap,nfft, Fs, 'yaxis')
ylim([0, 60]);
ylabel('Interval 2 (Frequency (Hz))');

subplot(4,1,3);
spectrogram(I3,window,noverlap,nfft, Fs, 'yaxis')
ylim([0, 60]);
ylabel('Interval 3 (Frequency (Hz))');

subplot(4,1,4);
spectrogram(I4,window,noverlap,nfft, Fs, 'yaxis')
ylim([0, 60]);
ylabel('Interval 4 (Frequency (Hz))');

%% 1-9
N = 4;
I2_filtered = lowpass(I2, 30, Fs);
I2_downS = downsample(I2_filtered, N);
[fftI2_dS, fI2_dS] = my_fft(I2_downS, Fs/N);

% time
figure;
subplot(2,2,1);
plot(30:1/(Fs):35, I2);
myPlotProp('auto', [-40 60], 'Time domain for interval 2', 'Time ($s$)', 'Amplitude', 'off', 14);
subplot(2,2,3);
plot(30:1/(Fs/N):35, I2_downS);
myPlotProp('auto', [-40 60], "Time domain for interval 2, down sampled by "+N, 'Time ($s$)', 'Amplitude', 'off', 14);

% freq
subplot(2,2,2);
plot(fI2, fftI2);
myPlotProp([0,60], [0 4], 'Freq domain for interval 2', 'f(Hz)', 'Amplitude', 'off', 14);
subplot(2,2,4);
plot(fI2_dS, fftI2_dS);
myPlotProp([0,60], [0 4], "Freq domain for interval 2, down sampled by "+N, 'f(Hz)', 'Amplitude', 'off', 14);

% time-freq
window = hamming(128);
noverlap = 64;
nfft = 128;

figure;
subplot(2,1,1);
spectrogram(I2,window,noverlap,nfft, Fs, 'yaxis');
title('Spectrogram of Original Signal');
subplot(2,1,2);
spectrogram(I2_downS,window,noverlap,nfft, Fs/N, 'yaxis');
title('Spectrogram of Down Sampled Signal');

%% Functions

function myPlotProp(my_xlim, my_ylim, my_title, my_xlabel, my_ylabel, my_legend, fontsize)
    grid minor; xlim(my_xlim); ylim(my_ylim);
    title(my_title, 'interpreter', 'latex', 'fontsize', fontsize+3);
    xlabel(my_xlabel, 'interpreter', 'latex', 'fontsize', fontsize);
    ylabel(my_ylabel, 'interpreter', 'latex', 'fontsize', fontsize);
    legend(my_legend, 'interpreter', 'latex', 'fontsize', fontsize-2);
end

function [out, f] = my_fft(x, Fs)
    Y = fft(x);
    L = size(x, 2);
    P2 = abs(Y/L);
    P1 = P2(1:ceil(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:ceil(L/2))/L;
    out = P1;
end

