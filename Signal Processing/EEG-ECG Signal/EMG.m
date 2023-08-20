clc; clear; close all;
load('Lab 1_data/EMG_sig.mat');

%% Time Analysis
L1 = length(emg_healthym);
L2 = length(emg_neuropathym);
L3 = length(emg_myopathym);
t1 = 0:1/fs:(L1-1)/fs;
t2 = 0:1/fs:(L2-1)/fs;
t3 = 0:1/fs:(L3-1)/fs;

figure;
subplot(3,1,1);
% subplot(3,5,[2 3 4]);
plot(t1, emg_healthym/10000, 'linewidth', 1.5);
myPlotProp([], [], 'Healthy Person EMG', 'Time ($s$)', 'Amplitude ($mV$)', 'off', '', 13);
subplot(3,1,2);
% subplot(3,5,[7 8 9]);
plot(t2, emg_neuropathym/10000, 'linewidth', 1.5);
myPlotProp([], [], 'Patient with Neuropathy EMG', 'Time ($s$)', 'Amplitude ($mV$)', 'off', '', 13);
subplot(3,1,3);
% subplot(3,5,[12 13 14]);
plot(t3, emg_myopathym/10000, 'linewidth', 1.5);
myPlotProp([], [], 'Patient with Myopathy EMG', 'Time ($s$)', 'Amplitude ($mV$)', 'off', '', 13);

figure;
% subplot(3,1,1);
subplot(3,5,[2 3 4]);
plot(t1, emg_healthym/10000, 'linewidth', 1.5);
myPlotProp([1 1.5], [], 'Healthy Person EMG', 'Time ($s$)', 'Amplitude ($mV$)', 'off', '', 11);
% subplot(3,1,2);
subplot(3,5,[7 8 9]);
plot(t2, emg_neuropathym/10000, 'linewidth', 1.5);
myPlotProp([1 1.5], [], 'Patient with Neuropathy EMG', 'Time ($s$)', 'Amplitude ($mV$)', 'off', '', 11);
% subplot(3,1,3);
subplot(3,5,[12 13 14]);
plot(t3, emg_myopathym/10000, 'linewidth', 1.5);
myPlotProp([1 1.5], [], 'Patient with Myopathy EMG', 'Time ($s$)', 'Amplitude ($mV$)', 'off', '', 11);

%% Frequency Analysis
figure;
subplot(3,1,1);
pwelch(emg_healthym, [], [], [], fs);
myPlotProp([], [0 60], 'PSD of Healthy Person EMG', 'Frequency (kHz)', 'Power/Freq (dB/Hz)', 'off', '', 14);
subplot(3,1,2);
pwelch(emg_neuropathym, [], [], [], fs);
myPlotProp([], [0 60], 'PSD of Patient with Neuropathy EMG', 'Frequency (kHz)', 'Power/Freq (dB/Hz)', 'off', '', 14);
subplot(3,1,3);
pwelch(emg_myopathym, [], [], [], fs);
myPlotProp([], [0 60], 'PSD of Patient with Myopathy EMG', 'Frequency (kHz)', 'Power/Freq (dB/Hz)', 'off', '', 14);

%% Time-Frequency Analysis
figure;
subplot(3,1,1);
stft(emg_healthym, fs);
myPlotProp([], [], 'STFT of Healthy Person EMG', 'Time ($s$)', 'Frequency (kHz)', 'off', '', 14);
subplot(3,1,2);
stft(emg_neuropathym, fs);
myPlotProp([], [], 'STFT of Patient with Neuropathy EMG', 'Time ($s$)', 'Frequency (kHz)', 'off', '', 14);
subplot(3,1,3);
stft(emg_myopathym, fs);
myPlotProp([], [], 'STFT of Patient with Myopathy EMG', 'Time ($s$)', 'Frequency (kHz)', 'off', '', 14);

figure;
subplot(3,1,1);
stft(emg_healthym, fs);
myPlotProp([1 1.5], [], 'STFT of Healthy Person EMG', 'Time ($s$)', 'Frequency (kHz)', 'off', '', 14);
subplot(3,1,2);
stft(emg_neuropathym, fs);
myPlotProp([1 1.5], [], 'STFT of Patient with Neuropathy EMG', 'Time ($s$)', 'Frequency (kHz)', 'off', '', 14);
subplot(3,1,3);
stft(emg_myopathym, fs);
myPlotProp([1 1.5], [], 'STFT of Patient with Myopathy EMG', 'Time ($s$)', 'Frequency (kHz)', 'off', '', 14);

%% Functions

function myPlotProp(my_xlim, my_ylim, my_title, my_xlabel, my_ylabel, my_legend, my_legend_tit, fontsize)
    grid minor;
    if length(my_xlim)>1
        xlim(my_xlim);
    elseif length(my_ylim)>1
        ylim(my_ylim);
    end
    title(my_title, 'interpreter', 'latex', 'fontsize', fontsize+5);
    if my_legend ~= "off"
        lgd = legend(my_legend, 'interpreter', 'latex', 'location', 'best' ,'fontsize', fontsize-2);
        title(lgd, my_legend_tit, 'interpreter', 'latex', 'fontsize', fontsize-2);
    end
    xlabel(my_xlabel, 'interpreter', 'latex', 'fontsize', fontsize);
    ylabel(my_ylabel, 'interpreter', 'latex', 'fontsize', fontsize);
end
