

%% part 2-ECG
close all; clc; clear;
load('ECG_sig.mat');
%% Two channels signal in time

t = 0:1/sfreq:(size(Sig,1)/sfreq)-1/sfreq;

figure
subplot(2,1,1)
plot(t,Sig(:,1))
ylabel('Amplitude','Interpreter','latex')
title('First Channel in Time','Interpreter','latex')

subplot(2,1,2)
plot(t,Sig(:,2))
xlabel('time(s)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex')
title('Second Channel in Time','Interpreter','latex')

figure
subplot(2,1,1)
plot(t,Sig(:,1))
ylabel('Amplitude','Interpreter','latex')
title('First Channel in Time','Interpreter','latex')
xlim([300 305])

subplot(2,1,2)
plot(t,Sig(:,2))
xlabel('time(s)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex')
title('Second Channel in Time','Interpreter','latex')
xlim([300 305])
%% Find PQRST
clc
duration= 12*sfreq;
ECG_data= Sig(1:duration,1);
[~,locs_Rwave] = findpeaks(ECG_data,'MinPeakHeight',0.5);

figure
hold all
grid on
plot(t(1:duration),ECG_data)

plot(5.19,ECG_data(round(5.19*sfreq)),'magentav','MarkerFaceColor','magenta')%P
plot(5.28,ECG_data(round(5.29*sfreq)),'yellowv','MarkerFaceColor','yellow')%Q
plot(locs_Rwave(8)./sfreq,ECG_data(locs_Rwave(8)),'rv','MarkerFaceColor','r')%R
plot(5.49,ECG_data(round(5.49*sfreq)),'bv','MarkerFaceColor','b')%S
plot(5.71,ECG_data(round(5.71*sfreq)),'gv','MarkerFaceColor','g')%T


plot(5.95,ECG_data(round(5.95*sfreq)),'magentav','MarkerFaceColor','magenta')%P
plot(6.05,ECG_data(round(6.05*sfreq)),'yellowv','MarkerFaceColor','yellow')%Q
plot(locs_Rwave(9)./sfreq,ECG_data(locs_Rwave(9)),'rv','MarkerFaceColor','r')%R
plot(6.239,ECG_data(round(6.239*sfreq)),'bv','MarkerFaceColor','b')%S
plot(6.44,ECG_data(round(6.44*sfreq)),'gv','MarkerFaceColor','g')%T

legend('ECG-signal','P-wave','Q-wave','R-wave','S-wave','T-wave')
xlim([4.5 6.8])

xlabel('time(s)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex')
title('Cardiac Cycle','Interpreter','latex')
%% Normalized and unnormalized heart rate
clc
data_ch1 = Sig(:,1);
data_ch2 = Sig(:,2);
t = 0:1/sfreq:(650000/360)-1/sfreq;

indx = ceil(ATRTIMED.*sfreq);

hold all;
fig= figure;
for i = 50:60 %636:647
    subplot(2,1,1)
    d1= round((indx(i)-indx(i-1))/2); d2=round((indx(i+1)-indx(i))/2);
    plot(t(indx(i)-d1:indx(i)+d2),data_ch1(indx(i)-d1:indx(i)+d2)); hold on;
        
    subplot(2,1,1)
    plot(ATRTIMED(i),data_ch1(indx(i),1),'o','MarkerSize',5,'MarkerEdgeColor','black','MarkerFaceColor','black'); hold on;    
    text(ATRTIMED(i),data_ch1(indx(i),1),num2str(ANNOTD(i)));hold on;
    
    subplot(2,1,2)
    plot(t(indx(i)-d1:indx(i)+d2),data_ch2(indx(i)-d1:indx(i)+d2)); hold on;
    plot(ATRTIMED(i),data_ch2(indx(i),1),'o','MarkerSize',5,'MarkerEdgeColor','black','MarkerFaceColor','black');hold on;
    text(ATRTIMED(i),data_ch2(indx(i),1),num2str(ANNOTD(i)));hold on;
end

han=axes(fig,'visible','off');
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Amplitude','Interpreter','latex');
xlabel(han,'Time(s)','Interpreter','latex');
title(han,'Some Kind of Unnormalized Heart Rate','Interpreter','latex');

%% Compare different unnormalized heart rate
%1-->7:10
%4-->1641:1643
%5-->745:749
%6-->1579:1580
%7-->714:716
%8-->1259:1262
%11-->554:559
%14-->1239:1:1241
%28-->709:712
%37-->1705:1711

fig=figure;

for i = 1239:1:1241
    subplot(2,1,1)
    d1= round((indx(i)-indx(i-1))/2); d2=round((indx(i+1)-indx(i))/2);
    plot(t(indx(i)-d1:indx(i)+d2),data_ch1(indx(i)-d1:indx(i)+d2)); hold on;
        
    subplot(2,1,1)
    plot(ATRTIMED(i),data_ch1(indx(i),1),'o','MarkerSize',5,'MarkerEdgeColor','black','MarkerFaceColor','black');  
    hold on;    
    text(ATRTIMED(i),data_ch1(indx(i),1),num2str(ANNOTD(i)));hold on;
    
    subplot(2,1,2)
    plot(t(indx(i)-d1:indx(i)+d2),data_ch2(indx(i)-d1:indx(i)+d2)); hold on;
  
    plot(ATRTIMED(i),data_ch2(indx(i),1),'o','MarkerSize',5,'MarkerEdgeColor','black','MarkerFaceColor','black')
    hold on;
    text(ATRTIMED(i),data_ch2(indx(i),1),num2str(ANNOTD(i)))

    hold on;
end

han=axes(fig,'visible','off');
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
xlabel('time(s)','Interpreter','latex')
ylabel('Amplitude','Interpreter','latex')
title('Signal Quality Change','Interpreter','latex');
%% Frequency/time-frequency Analyse
clc
%10:47
%707:710
data1 = data_ch2(indx(707):indx(710));
data2 = data_ch2(indx(707):indx(710));

window=hamming(180); noverlap=179; nfft=1024;
figure
spectrogram(data1,window,noverlap,nfft,sfreq,'yaxis')
title('Signal Spectrogram','Interpreter','latex')
figure
pwelch(data1,window,noverlap,nfft,sfreq)
%% part3-EOG
clc; clear; close all;
load('Lab 1_data/EOG_sig.mat');

%% Time Analysis
L = size(Sig, 2);
t = 0:1/fs:(L-1)/fs;
plot(t, Sig(1,:), 'linewidth', 1.5); hold on;
plot(t, Sig(2,:), 'linewidth', 1.5);
myPlotProp([], [], 'EOG Signal', 'Time ($s$)', 'Voltage ($\mu V$)', [""+Labels{1}; ""+Labels{2}], 'Label', 16);

%% Frequency Analysis
figure;
subplot(2,1,1);
pwelch(Sig(1,:), [], [], [], fs);
myPlotProp([0 60], [], Labels{1}+", EOG Signal PSD", 'Frequency ($f$)', 'Power/Frequency (dB/Hz)', 'off', '', 15);
subplot(2,1,2);
pwelch(Sig(2,:), [], [], [], fs);
myPlotProp([0 60], [], Labels{2}+", EOG Signal PSD", 'Frequency ($f$)', 'Power/Frequency (dB/Hz)', 'off', '', 15);

%% Time-Frequency Analysis
figure;
subplot(2,1,1);
stft(Sig(1,:), fs);
myPlotProp([], [], Labels{1}+", EOG Signal STFT", 'Time ($s$)', 'Frequency (Hz)', 'off', '', 15);
subplot(2,1,2);
stft(Sig(2,:), fs);
myPlotProp([], [], Labels{2}+", EOG Signal STFT", 'Time ($s$)', 'Frequency (Hz)', 'off', '', 15);
%% part4-EMG
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
plot(t1, emg_healthym/1000, 'linewidth', 1.5);
myPlotProp([], [], 'Healthy Person EMG', 'Time ($s$)', 'Amplitude ($mV$)', 'off', '', 13);
subplot(3,1,2);
% subplot(3,5,[7 8 9]);
plot(t2, emg_neuropathym/1000, 'linewidth', 1.5);
myPlotProp([], [], 'Patient with Neuropathy EMG', 'Time ($s$)', 'Amplitude ($mV$)', 'off', '', 13);
subplot(3,1,3);
% subplot(3,5,[12 13 14]);
plot(t3, emg_myopathym/1000, 'linewidth', 1.5);
myPlotProp([], [], 'Patient with Myopathy EMG', 'Time ($s$)', 'Amplitude ($mV$)', 'off', '', 13);

figure;
% subplot(3,1,1);
subplot(3,5,[2 3 4]);
plot(t1, emg_healthym/1000, 'linewidth', 1.5);
myPlotProp([1 1.5], [], 'Healthy Person EMG', 'Time ($s$)', 'Amplitude ($mV$)', 'off', '', 13);
% subplot(3,1,2);
subplot(3,5,[7 8 9]);
plot(t2, emg_neuropathym/1000, 'linewidth', 1.5);
myPlotProp([1 1.5], [], 'Patient with Neuropathy EMG', 'Time ($s$)', 'Amplitude ($mV$)', 'off', '', 13);
% subplot(3,1,3);
subplot(3,5,[12 13 14]);
plot(t3, emg_myopathym/1000, 'linewidth', 1.5);
myPlotProp([1 1.5], [], 'Patient with Myopathy EMG', 'Time ($s$)', 'Amplitude ($mV$)', 'off', '', 13);

%% Frequency Analysis
figure;
subplot(3,1,1);
pwelch(emg_healthym, [], [], [], fs);
myPlotProp([], [0 60], 'PSD of Healthy Person EMG', 'Frequency (kHz)', 'Power/Frequency (dB/Hz)', 'off', '', 15);
subplot(3,1,2);
pwelch(emg_neuropathym, [], [], [], fs);
myPlotProp([], [0 60], 'PSD of Patient with Neuropathy EMG', 'Frequency (kHz)', 'Power/Frequency (dB/Hz)', 'off', '', 15);
subplot(3,1,3);
pwelch(emg_myopathym, [], [], [], fs);
myPlotProp([], [0 60], 'PSD of Patient with Myopathy EMG', 'Frequency (kHz)', 'Power/Frequency (dB/Hz)', 'off', '', 15);

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





