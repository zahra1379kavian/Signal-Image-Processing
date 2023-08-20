%%%%%% Lab5 %%%%%%

%% Part 2
close all; clear; clc;

%% Part A
close all;

n_605 = load('./Lab 5_data/n_605.mat');
n_418 = load('./Lab 5_data/n_418.mat');
n_421 = load('./Lab 5_data/n_421.mat');
n_422 = load('./Lab 5_data/n_422.mat');
n_423 = load('./Lab 5_data/n_423.mat');
n_424 = load('./Lab 5_data/n_424.mat');
n_425 = load('./Lab 5_data/n_425.mat');
n_426 = load('./Lab 5_data/n_426.mat');
n_429 = load('./Lab 5_data/n_429.mat');
n_430 = load('./Lab 5_data/n_430.mat');

n_605 = n_605.n_605;
n_418 = n_418.n_418;
n_421 = n_421.n_421;
n_422 = n_422.n_422;
n_423 = n_423.n_423;
n_424 = n_424.n_424;
n_425 = n_425.n_425;
n_426 = n_426.n_426;
n_429 = n_429.n_429;
n_430 = n_430.n_430;

Fs = 250;
t = 0:1/Fs:5*60-1/Fs;


%% Part B

% n_422_I1 = n_422(1:0.004*Fs);
n_422_I1 = n_422(0.004*Fs+1:42.844*Fs);
n_422_I2 = n_422(42.844*Fs+1:44.844*Fs);
n_422_I3 = n_422(44.844*Fs+1:45.768*Fs);
n_422_I4 = n_422(45.768*Fs+1:(3*60+58.844)*Fs);
n_422_I5 = n_422((3*60+58.844)*Fs+1:(4*60+5.152)*Fs);
n_422_I6 = n_422((4*60+5.152)*Fs+1:end);


fontsize = 12;
figure;

subplot(6,1,1);
plot(t(0.004*Fs+1:42.844*Fs), n_422_I1);
myPlotProp('auto', 'auto', '$n_{422}$ from 0 to 5 mins', 'time(s)', '', 'off', fontsize)

subplot(6,1,2);
plot(t(42.844*Fs+1:44.844*Fs), n_422_I2);
myPlotProp('auto', 'auto', '$n_{424}$ from 0 to 5 mins', 'time(s)', '', 'off', fontsize)

subplot(6,1,3);
plot(t(44.844*Fs+1:45.768*Fs), n_422_I3);
myPlotProp('auto', 'auto', '$n_{430}$ from 0 to 5 mins', 'time(s)', '', 'off', fontsize)

subplot(6,1,4);
plot(t(45.768*Fs+1:(3*60+58.844)*Fs), n_422_I4);
myPlotProp('auto', 'auto', '$n_{605}$ from 0 to 5 mins', 'time(s)', '', 'off', fontsize)

subplot(6,1,5);
plot(t((3*60+58.844)*Fs+1:(4*60+5.152)*Fs), n_422_I5);
myPlotProp('auto', 'auto', '$n_{605}$ from 0 to 5 mins', 'time(s)', '', 'off', fontsize)

subplot(6,1,6);
plot(t((4*60+5.152)*Fs+1:end), n_422_I6);
myPlotProp('auto', 'auto', '$n_{605}$ from 0 to 5 mins', 'time(s)', '', 'off', fontsize)

window = hamming(128);
noverlap = 64;
nfft = 128;
figure

subplot(6,1,1);
pwelch(n_422_I1,window,noverlap,nfft, Fs);
% xlim([0, 60]);
% ylabel('Interval 2 (Power/freq) (dB/Hz)');

subplot(6,1,2);
pwelch(n_422_I2,window,noverlap,nfft, Fs);
% xlim([0, 60]);
% ylabel('Interval 3 (Power/freq) (dB/Hz)');

subplot(6,1,3);
pwelch(n_422_I3,window,noverlap,nfft, Fs);
% xlim([0, 60]);
% ylabel('Interval 4 (Power/freq) (dB/Hz)');

subplot(6,1,4);
pwelch(n_422_I4,window,noverlap,nfft, Fs);
% xlim([0, 60]);
% ylabel('Interval 4 (Power/freq) (dB/Hz)');

subplot(6,1,5);
pwelch(n_422_I5,window,noverlap,nfft, Fs);
% xlim([0, 60]);
% ylabel('Interval 4 (Power/freq) (dB/Hz)');

subplot(6,1,6);
pwelch(n_422_I6,window,noverlap,nfft, Fs);
% xlim([0, 60]);
% ylabel('Interval 4 (Power/freq) (dB/Hz)');





% n_424_I1 = n_424(1:0.004*Fs);
n_424_I1 = n_424(0.004*Fs+1:(60+48.996)*Fs);
n_424_I2 = n_424((60+48.996)*Fs+1:(3*60+34.692)*Fs);
n_424_I3 = n_424((3*60+34.692)*Fs+1:(3*60+40.536)*Fs);
n_424_I4 = n_424((3*60+40.536)*Fs+1:(3*60+53.152)*Fs);
n_424_I5 = n_424((3*60+53.152)*Fs+1:end);

fontsize = 12;
figure;

subplot(5,1,1);
plot(t(0.004*Fs+1:(60+48.996)*Fs), n_424_I1);
myPlotProp('auto', 'auto', '$n_{422}$ from 0 to 5 mins', 'time(s)', '', 'off', fontsize)

subplot(5,1,2);
plot(t((60+48.996)*Fs+1:(3*60+34.692)*Fs), n_424_I2);
myPlotProp('auto', 'auto', '$n_{424}$ from 0 to 5 mins', 'time(s)', '', 'off', fontsize)

subplot(5,1,3);
plot(t((3*60+34.692)*Fs+1:(3*60+40.536)*Fs), n_424_I3);
myPlotProp('auto', 'auto', '$n_{430}$ from 0 to 5 mins', 'time(s)', '', 'off', fontsize)

subplot(5,1,4);
plot(t((3*60+40.536)*Fs+1:(3*60+53.152)*Fs), n_424_I4);
myPlotProp('auto', 'auto', '$n_{605}$ from 0 to 5 mins', 'time(s)', '', 'off', fontsize)

subplot(5,1,5);
plot(t((3*60+53.152)*Fs+1:end), n_424_I5);
myPlotProp('auto', 'auto', '$n_{605}$ from 0 to 5 mins', 'time(s)', '', 'off', fontsize)

window = hamming(128);
noverlap = 64;
nfft = 128;
figure;

subplot(5,1,1);
pwelch(n_424_I1,window,noverlap,nfft, Fs);
% xlim([0, 60]);
% ylabel('Interval 2 (Power/freq) (dB/Hz)');

subplot(5,1,2);
pwelch(n_424_I2,window,noverlap,nfft, Fs);
% xlim([0, 60]);
% ylabel('Interval 3 (Power/freq) (dB/Hz)');

subplot(5,1,3);
pwelch(n_424_I3,window,noverlap,nfft, Fs);
% xlim([0, 60]);
% ylabel('Interval 4 (Power/freq) (dB/Hz)');

subplot(5,1,4);
pwelch(n_424_I4,window,noverlap,nfft, Fs);
% xlim([0, 60]);
% ylabel('Interval 4 (Power/freq) (dB/Hz)');

subplot(5,1,5);
pwelch(n_424_I5,window,noverlap,nfft, Fs);
% xlim([0, 60]);
% ylabel('Interval 4 (Power/freq) (dB/Hz)');


%% Part C

timearr = timeArr();

% labels(1:20) = 1;
% labels(21:22) = 0;
% labels(23:41) = 2;
% labels(42:47) = 0;
% labels(47:end) = 5;

sampleNumber = timearr*Fs;
sampleNumber(:,1)=sampleNumber(:,1)+1;

%% Part D

% n_data = n_422; labels = getLabels("n_422");
n_data = n_424; labels = getLabels("n_424");

Features = zeros(59,8);

for i=1:59
    Features(i,1)=bandpower(n_data(sampleNumber(i,1):sampleNumber(i,2)),Fs,[1,40]);
    Features(i,2)=bandpower(n_data(sampleNumber(i,1):sampleNumber(i,2)),Fs,[41,80]);
    Features(i,3)=bandpower(n_data(sampleNumber(i,1):sampleNumber(i,2)),Fs,[81,120]);
    Features(i,4)=bandpower(n_data(sampleNumber(i,1):sampleNumber(i,2)),Fs,[1,120]);
    Features(i,5)=meanfreq(n_data(sampleNumber(i,1):sampleNumber(i,2)),Fs);
    Features(i,6)=medfreq(n_data(sampleNumber(i,1):sampleNumber(i,2)),Fs);
    Features(i,7)=bandpower(n_data(sampleNumber(i,1):sampleNumber(i,2)),Fs,[30,60]);
    Features(i,8)=bandpower(n_data(sampleNumber(i,1):sampleNumber(i,2)),Fs,[12,30]);
end

%% Part E
close all;

figure
histogram(Features(find(labels==1),1),'Normalization', 'pdf');
hold on
histogram(Features(find(labels==2),1),'Normalization', 'pdf');
title('bandpower([1 40])'); legend('Normal', 'VFIB');

figure
histogram(Features(find(labels==1),2),'Normalization', 'pdf');
hold on
histogram(Features(find(labels==2),2),'Normalization', 'pdf');
title('bandpower([41 80])'); legend('Normal', 'VFIB');

figure
histogram(Features(find(labels==1),3),'Normalization', 'pdf');
hold on
histogram(Features(find(labels==2),3),'Normalization', 'pdf');
title('bandpower([81 120])'); legend('Normal', 'VFIB');

figure
histogram(Features(find(labels==1),4),'Normalization', 'pdf');
hold on
histogram(Features(find(labels==2),4),'Normalization', 'pdf');
title('bandpower([1 120])'); legend('Normal', 'VFIB');

figure
histogram(Features(find(labels==1),5),'Normalization', 'pdf');
hold on
histogram(Features(find(labels==2),5),'Normalization', 'pdf');
title('meanfreq()'); legend('Normal', 'VFIB');

figure
histogram(Features(find(labels==1),6),'Normalization', 'pdf');
hold on
histogram(Features(find(labels==2),6),'Normalization', 'pdf');
title('medfreq()'); legend('Normal', 'VFIB');

figure
histogram(Features(find(labels==1),7),'Normalization', 'pdf');
hold on
histogram(Features(find(labels==2),7),'Normalization', 'pdf');
title('bandpower([30 60])'); legend('Normal', 'VFIB');

figure
histogram(Features(find(labels==1),8),'Normalization', 'pdf');
hold on
histogram(Features(find(labels==2),8),'Normalization', 'pdf');
title('bandpower([12 30])'); legend('Normal', 'VFIB');

%% Part F

close all;
% thresholds1 = [2.5 14]; time_stat = 1;
thresholds1 = [2.5 0.15]; time_stat = 3;

[alarm1, ~] = va_detect(n_data, Fs, 1, thresholds1, time_stat);
[alarm2, ~] = va_detect(n_data, Fs, 2, thresholds1, time_stat);

%% Part G

normal_ind = find(labels == 1);
VFIB_ind = find(labels == 2);

C1 = confusionmat(labels([normal_ind; VFIB_ind])-1, alarm1([normal_ind; VFIB_ind]));
figure; plotconfusion((labels([normal_ind; VFIB_ind])-1)', alarm1([normal_ind; VFIB_ind])', 'Feature 1');
C2 = confusionmat(labels([normal_ind; VFIB_ind])-1, alarm2([normal_ind; VFIB_ind]));
figure; plotconfusion((labels([normal_ind; VFIB_ind])-1)', alarm2([normal_ind; VFIB_ind])', 'Feature 2');

%% Part H

Features_stat = zeros(59,7);

for i=1:59
    Features_stat(i,1)=max(n_data(sampleNumber(i,1):sampleNumber(i,2)));
    Features_stat(i,2)=min(n_data(sampleNumber(i,1):sampleNumber(i,2)));
    Features_stat(i,3)=peak2peak(n_data(sampleNumber(i,1):sampleNumber(i,2)));
    Features_stat(i,4)=mean(findpeaks(n_data(sampleNumber(i,1):sampleNumber(i,2))));
    Features_stat(i,5)=mean(findpeaks(-1*n_data(sampleNumber(i,1):sampleNumber(i,2))));
    Features_stat(i,6)=zeroDetect(n_data(sampleNumber(i,1):sampleNumber(i,2)));
    Features_stat(i,7)=var(n_data(sampleNumber(i,1):sampleNumber(i,2)));
end

%% Part I

figure
histogram(Features_stat(labels==1,1),'Normalization', 'pdf');
hold on
histogram(Features_stat(labels==2,1),'Normalization', 'pdf');
title('max()'); legend('Normal', 'VFIB');

figure
histogram(Features_stat(labels==1,2),'Normalization', 'pdf');
hold on
histogram(Features_stat(labels==2,2),'Normalization', 'pdf');
title('min()'); legend('Normal', 'VFIB');

figure
histogram(Features_stat(labels==1,3),'Normalization', 'pdf');
hold on
histogram(Features_stat(labels==2,3),'Normalization', 'pdf');
title('peak2peak()'); legend('Normal', 'VFIB');

figure
histogram(Features_stat(labels==1,4),'Normalization', 'pdf');
hold on
histogram(Features_stat(labels==2,4),'Normalization', 'pdf');
title('mean(findpeaks())'); legend('Normal', 'VFIB');

figure
histogram(Features_stat(labels==1,5),'Normalization', 'pdf');
hold on
histogram(Features_stat(labels==2,5),'Normalization', 'pdf');
title('mean(findpeaks(-1*signal))'); legend('Normal', 'VFIB');

figure
histogram(Features_stat(labels==1,6),'Normalization', 'pdf');
hold on
histogram(Features_stat(labels==2,6),'Normalization', 'pdf');
title('zeroDetect()'); legend('Normal', 'VFIB');

figure
histogram(Features_stat(labels==1,7),'Normalization', 'pdf');
hold on
histogram(Features_stat(labels==2,7),'Normalization', 'pdf');
title('var()'); legend('Normal', 'VFIB');

%% Part J

close all;
% thresholds2 = [-25 87.5]; time_stat = 2;
thresholds2 = [30 4000]; time_stat = 4;

[alarm1_stat, ~] = va_detect(n_data, Fs, 1, thresholds2, time_stat);
[alarm2_stat, ~] = va_detect(n_data, Fs, 2, thresholds2, time_stat);

%% Part K

normal_ind = find(labels == 1);
VFIB_ind = find(labels == 2);

C1_stat = confusionmat(labels([normal_ind; VFIB_ind])-1, alarm1_stat([normal_ind; VFIB_ind]));
figure; plotconfusion((labels([normal_ind; VFIB_ind])-1)', alarm1_stat([normal_ind; VFIB_ind])', 'Feature 1');
C2_stat = confusionmat(labels([normal_ind; VFIB_ind])-1, alarm2_stat([normal_ind; VFIB_ind]));
figure; plotconfusion((labels([normal_ind; VFIB_ind])-1)', alarm2_stat([normal_ind; VFIB_ind])', 'Feature 2');

%% Part N
Feature_vv = zeros(59, 2);
for i=1:59
    Feature_vv(i,1) = bandpower(n_424(sampleNumber(i,1):sampleNumber(i,2)),Fs,[41,80]);
    Feature_vv(i,2) = zeroDetect(n_422(sampleNumber(i,1):sampleNumber(i,2)));
end

labels = getLabels("n_424");
figure
histogram(Feature_vv(labels==1,1),'Normalization', 'pdf');
hold on
histogram(Feature_vv(labels==2,1),'Normalization', 'pdf');

normal_ind = find(labels == 1);
VFIB_ind = find(labels == 2);
[alarm1_vv, ~] = va_detect(n_424, Fs, 1, [2.5 0], 1);
figure; plotconfusion((labels([normal_ind; VFIB_ind])-1)', alarm1_vv([normal_ind; VFIB_ind])', 'Feature 1');


labels = getLabels("n_422");
figure
histogram(Feature_vv(labels==1,2),'Normalization', 'pdf');
hold on
histogram(Feature_vv(labels==2,2),'Normalization', 'pdf');

normal_ind = find(labels == 1);
VFIB_ind = find(labels == 2);
[alarm2_vv, ~] = va_detect(n_422, Fs, 2, [30 0], 4);
figure; plotconfusion((labels([normal_ind; VFIB_ind])-1)', alarm2_vv([normal_ind; VFIB_ind])', 'Feature 2');

%% Part O
last_feature = zeros(59, 2);
for i=1:59
    last_feature(i, 1) = bandpower(n_426(sampleNumber(i,1):sampleNumber(i,2)),Fs,[41,80]);
%     last_feature(i, 2) = bandpower(n_605(sampleNumber(i,1):sampleNumber(i,2)),Fs,[41,80]);
end

labels = getLabels("n_426");
figure;
histogram(last_feature(labels==1,1),'Normalization', 'pdf'); hold on;
histogram(last_feature(labels==2,1),'Normalization', 'pdf'); legend('Normal', 'Not Normal');

normal_ind = find(labels == 1);
VFIB_ind = find(labels == 2);
[alarm1_l, ~] = va_detect(n_426, Fs, 1, [2.5 0], 1);
figure; plotconfusion((labels([normal_ind; VFIB_ind])-1)', alarm1_l([normal_ind; VFIB_ind])', 'N426');

%% Functions
function myPlotProp(my_xlim, my_ylim, my_title, my_xlabel, my_ylabel, my_legend, fontsize)
    title(my_title, 'interpreter', 'latex', 'fontsize', fontsize+3);
    xlabel(my_xlabel, 'interpreter', 'latex', 'fontsize', fontsize);
    ylabel(my_ylabel, 'interpreter', 'latex', 'fontsize', fontsize);
    legend(my_legend, 'interpreter', 'latex', 'fontsize', fontsize-2);
    xlim(my_xlim); ylim(my_ylim);
end

function out = timeArr()
    out = zeros(59, 2);
    for i=1:59
        out(i,1) = 5*i-5;
        out(i,2) = 5*i+5;
    end
end

function [alarm,t] = va_detect(ecg_data,Fs,feature_num,Feature_th,time_stat)
%VA_DETECT  ventricular arrhythmia detection skeleton function
%  [ALARM,T] = VA_DETECT(ECG_DATA,FS) is a skeleton function for ventricular
%  arrhythmia detection, designed to help you get started in implementing your
%  arrhythmia detector.
%
%  This code automatically sets up fixed length data frames, stepping through 
%  the entire ECG waveform with 50% overlap of consecutive frames. You can customize 
%  the frame length  by adjusting the internal 'frame_sec' variable and the overlap by
%  adjusting the 'overlap' variable.
%
%  ECG_DATA is a vector containing the ecg signal, and FS is the sampling rate
%  of ECG_DATA in Hz. The output ALARM is a vector of ones and zeros
%  corresponding to the time frames for which the alarm is active (1) 
%  and inactive (0). T is a vector the same length as ALARM which contains the 
%  time markers which correspond to the end of each analyzed time segment. If Fs 
%  is not entered, the default value of 250 Hz is used. 

  %  Template Last Modified: 3/4/06 by Eric Weiss, 1/25/07 by Julie Greenberg


%  Processing frames: adjust frame length & overlap here
%------------------------------------------------------
frame_sec = 10;  % sec
overlap = 0.5;    % 50% overlap between consecutive frames


% Input argument checking
%------------------------
if nargin < 2
    Fs = 250;  % default sample rate
end;
if nargin < 1
    error('You must enter an ECG data vector.');
end;
ecg_data = ecg_data(:);  % Make sure that ecg_data is a column vector
 

% Initialize Variables
%---------------------
frame_length = round(frame_sec*Fs);  % length of each data frame (samples)
frame_step = round(frame_length*(1-overlap));  % amount to advance for next data frame
ecg_length = length(ecg_data);  % length of input vector
frame_N = floor((ecg_length-(frame_length-frame_step))/frame_step); % total number of frames
alarm = zeros(frame_N,1);	% initialize output signal to all zeros
t = ([0:frame_N-1]*frame_step+frame_length)/Fs;

% Analysis loop: each iteration processes one frame of data
%----------------------------------------------------------
Features = zeros(frame_N,2);
for i = 1:frame_N
    %  Get the next data segment
    seg = ecg_data(((i-1)*frame_step+1):((i-1)*frame_step+frame_length));
    %  Perform computations on the segment . . .
    switch time_stat
        case 1
            Features(i,1)=bandpower(seg,Fs,[41,80]); %2
            Features(i,2)=bandpower(seg,Fs,[30,60]); %7
        case 2
            Features(i,1)=mean(findpeaks(seg)); %4
            Features(i,2)=zeroDetect(seg); %6
        case 3
            Features(i,1)=bandpower(seg,Fs,[41,80]); %2
            Features(i,2)=medfreq(seg,Fs); %6
        case 4
            Features(i,1)=zeroDetect(seg); %6
            Features(i,2)=var(seg); %7
    end
        
    %  Decide whether or not to set alarm . . .
    if (feature_num==1 && time_stat == 4) || (time_stat == 2) || (feature_num==2 && time_stat == 3)
        if Features(i,feature_num)>Feature_th(feature_num)
            alarm(i) = 1;
        end
    else
        if Features(i,feature_num)<Feature_th(feature_num)
            alarm(i) = 1;
        end
    end
end
end

function num = zeroDetect(arr)
    num = 0;
    for i=2:length(arr)
        if sign(arr(i)) ~= sign(arr(i-1))
            num = num + 1;
        end
    end
end

function labels = getLabels(file_name)
    labels = zeros(59,1);
    if file_name == "n_422"
        labels(1:7) = 1;
        labels(8:10) = 0;
        labels(11:50) = 4;
        labels(51:end) = 2;
    elseif file_name == "n_424"
        labels(1:20) = 1;
        labels(21:22) = 0;
        labels(23:41) = 2;
        labels(42:end) = 0;
    elseif file_name == "n_426"
        labels(1:20) = 1;
        labels(21:end) = 2;
    end
end
