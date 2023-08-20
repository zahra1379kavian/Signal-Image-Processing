clc; clear; close all;
load('Lab 1_data/EOG_sig.mat');

%% Time Analysis
L = size(Sig, 2);
t = 0:1/fs:(L-1)/fs;
figure;
plot(t, Sig(1,:), 'linewidth', 1.5); hold on;
plot(t, Sig(2,:), 'linewidth', 1.5);
myPlotProp([], [], 'EOG Signal', 'Time ($s$)', 'Voltage ($\mu V$)', [""+Labels{1}; ""+Labels{2}], 'Label', 16);

%% Frequency Analysis
figure;
subplot(2,1,1);
pwelch(Sig(1,:), [], [], [], fs);
myPlotProp([], [], Labels{1}+", EOG Signal PSD", 'Frequency (Hz)', 'Power/Frequency (dB/Hz)', 'off', '', 15);
subplot(2,1,2);
pwelch(Sig(2,:), [], [], [], fs);
myPlotProp([], [], Labels{2}+", EOG Signal PSD", 'Frequency (Hz)', 'Power/Frequency (dB/Hz)', 'off', '', 15);

%% Time-Frequency Analysis
figure;
subplot(2,1,1);
stft(Sig(1,:), fs);
myPlotProp([], [], Labels{1}+", EOG Signal STFT", 'Time ($s$)', 'Frequency (Hz)', 'off', '', 15);
subplot(2,1,2);
stft(Sig(2,:), fs);
myPlotProp([], [], Labels{2}+", EOG Signal STFT", 'Time ($s$)', 'Frequency (Hz)', 'off', '', 15);

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
