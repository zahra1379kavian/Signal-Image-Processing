%% Ali Shahbazi     Zahra Kavian    MohammadReza Safavi

%% 1
clc; clear; close all;
load('SSVEP_EEG.mat'); Fs = 250;
channel_name = ["Pz", "Oz", "P7", "P8", "O2", "O1"];
t = (0:size(SSVEP_Signal,2)-1)/Fs;
SSVEP_Signal = SSVEP_Signal - mean(SSVEP_Signal, 2);

figure;
filtered_SSVEP = zeros(size(SSVEP_Signal));
for c=1:6
    tsin = timeseries(SSVEP_Signal(c,:), t);
    tsout = idealfilter(tsin, [1 40], 'pass');
    filtered_SSVEP(c,:) = tsout.Data;
    [SSVEP_PSD, f] = pwelch(filtered_SSVEP(c,:), [], [], [], Fs);
    subplot(2,3,c);
    plot(f, pow2db(SSVEP_PSD));
    myPlotProp([0 50], [], [], "PSD of SSVEP Signal, Channel " + channel_name(c), 'Frequency ($Hz$)', 'Power ($dB$)', '', 'off', '', 14);
end

%% 2
experiment = zeros(6, 5*Fs, 15);
for i=1:15
    experiment(:, :, i) = filtered_SSVEP(:, Event_samples(i):Event_samples(i)+5*Fs-1);
end

%% 3
for i=1:15
    figure;
    for c=1:6
        [pxx, f] = pwelch(experiment(c, :, i), [], [], [], Fs);
        plot(f, pow2db(pxx), 'linewidth', 1.5); hold on;
    end
    myPlotProp([0 50], [], [], "PSD of SSVEP Signal in Experiment " + i, 'Frequency ($Hz$)', 'Power ($dB$)', '', channel_name, '', 14);
end
