%% Ali Shahbazi     Zahra Kavian    MohammadReza Safavi

%% a
clc; clear; close all;

load('ERP_EEG.mat'); Fs = 240;
ERP_EEG = ERP_EEG';
t = 0:1/Fs:1-1/Fs;

figure;
my_legend = [];
for N=100:100:2500
    plot(t, mean(ERP_EEG(1:N, :)), 'linewidth', 1.5); hold on;
    my_legend = [my_legend; "$N=$ "+N];
end
myPlotProp([], [], [], 'Averaged Evoked Potential', 'Time ($s$)', 'Voltage ($\mu V$)', '', {my_legend, "out"}, 'Value of $N$', 16);

%% b, c
max_abs = zeros(1, size(ERP_EEG,1));
rms_error = zeros(1, size(ERP_EEG,1));
for N=1:size(ERP_EEG,1)
    max_abs(N) = max(abs(mean(ERP_EEG(1:N, :))));
    if N >= 2
        rms_error(N) = rms(mean(ERP_EEG(1:N, :)) - mean(ERP_EEG(1:N-1, :)));
    end
end
figure;
plot(1:size(ERP_EEG,1), max_abs, 'linewidth', 1.5);
myPlotProp([1 size(ERP_EEG,1)], [], [], 'Maximum Absolute Amplitude of ERP', '$N$', 'Voltage ($\mu V$)', '', 'off', '', 13);

figure;
plot(1:size(ERP_EEG,1), rms_error, 'linewidth', 1.5);
myPlotProp([1 size(ERP_EEG,1)], [], [], 'Root Mean Square Error', '$N$', 'Error', '', 'off', '', 13);

%% d
N0 = 500;
figure;
plot(t, mean(ERP_EEG(1:N0, :)), 'linewidth', 2); hold on;
plot(t, mean(ERP_EEG), 'linewidth', 2); hold on;
plot(t, mean(ERP_EEG(1:N0/3, :)), 'linewidth', 2); hold on;
N_prime = randi(2550, 1, N0);
plot(t, mean(ERP_EEG(N_prime, :)), 'linewidth', 2); hold on;
N_prime = randi(2550, 1, round(N0/3));
plot(t, mean(ERP_EEG(N_prime, :)), 'linewidth', 2);
plt_legend = ["$N=N_0$"; "$N=2550$"; "$N=\frac{N_0}{3}$"; "$N=rand(N_0)$"; "$N=rand(\frac{N_0}{3})$"];
myPlotProp([], [], [], 'Different AEP for some N', 'Time ($s$)', 'Voltage ($\mu V$)', '', plt_legend, 'Value of $N$', 16);
