%% Ali Shahbazi - Zahra Kavian - MohammadReza Safavi

%% Question 2
clc; clear; close all;

%% 1 
Fs = 250;
load('Electrodes.mat');
data_1 = load('NewData1.mat');
data_1 = data_1.EEG_Sig;
data_2 = load('NewData2.mat');
data_2 = data_2.EEG_Sig;
data_3 = load('NewData3.mat');
data_3 = data_3.EEG_Sig;
data_4 = load('NewData4.mat');
data_4 = data_4.EEG_Sig;
ElecName = Electrodes.labels;

disp_eeg(data_1, [], Fs, ElecName, 'NewData1 in time');
disp_eeg(data_2, [], Fs, ElecName, 'NewData2 in time');
disp_eeg(data_3, [], Fs, ElecName, 'NewData3 in time');
disp_eeg(data_4, [], Fs, ElecName, 'NewData4 in time');

%% 2
% in report

%% 3
[F1, W1, ~] = COM2R(data_1, size(data_1,1));
[F3, W3, ~] = COM2R(data_3, size(data_3,1));
ICA_data_1 = W1 * data_1;
ICA_data_3 = W3 * data_3;

%% 4
t = 0:1/Fs:(size(ICA_data_1,2)-1)/Fs;
% data 1
for s=1:21
    figure;
    subplot(3,2,[1 2]);
    plot(t, ICA_data_1(s, :), 'linewidth', 1.5);
    myPlotProp([], [], "Source "+s+" in Time", 'Time ($s$)', '', 'off', '', 13);
    
    subplot(3,2,[3 5]);
    [pxx, f]= pwelch(ICA_data_1(s, :), hamming(500), 300, 500, Fs);
    plot(f, 10*log10(pxx), 'linewidth', 1.5);
    myPlotProp([], [], "Source "+s+" in Frequency", 'Frequency (Hz)', '', 'off', '', 13);
    
    subplot(3,2,[4 6]);
    plottopomap(Electrodes.X, Electrodes.Y, Electrodes.labels, F1(:,s));
    title("Source " + s + " TopoMap");
end

%%
% data 3
for s=1:21
    figure;
    subplot(3,2,[1 2]);
    plot(t, ICA_data_3(s, :), 'linewidth', 1.5);
    myPlotProp([], [], "Source "+s+" in Time", 'Time ($s$)', '', 'off', '', 13);
    
    subplot(3,2,[3 5]);
    [pxx, f]= pwelch(ICA_data_3(s, :), hamming(500), 300, 500, Fs);
    plot(f, 10*log10(pxx), 'linewidth', 1.5);
    myPlotProp([], [], "Source "+s+" in Frequency", 'Frequency (Hz)', '', 'off', '', 13);
    
    subplot(3,2,[4 6]);
    plottopomap(Electrodes.X, Electrodes.Y, Electrodes.labels, F3(:,s));
    title("Source " + s + " TopoMap");
end

%% 4-2 
% this part is same as above but used for selecting
disp_eeg(ICA_data_1, [], Fs, 1:21, 'Data1 Sources in time'); ylabel('Sources', 'fontsize', 10);
figure;
for i=1:length(F1)
    subplot(3,7,i) ;
    plottopomap(Electrodes.X, Electrodes.Y, Electrodes.labels, F1(:,i)) ;
    title("Source " + i);
end

disp_eeg(ICA_data_3, [], Fs, 1:21, 'Data3 Sources in time'); ylabel('Sources', 'fontsize', 10);
figure;
for i=1:length(F3)
    subplot(3,7,i) ;
    plottopomap(Electrodes.X, Electrodes.Y, Electrodes.labels, F3(:,i)) ;
    title("Source " + i);
end

%% 5
SelSources_1 = [1 2 3 5 6 7 8 9 11 12 13 14 15 16 17 18 19 20 21];
SelSources_3 = [2 3 4 5 6 8 9 10 11 12 13 14 15 16 17 18 19 20 21];
data_1_denoised = F1(:,SelSources_1) * ICA_data_1(SelSources_1,:);
data_3_denoised = F3(:,SelSources_3) * ICA_data_3(SelSources_3,:);

disp_eeg(data_1_denoised, [], Fs, ElecName, 'Data 1 denoised in time');
disp_eeg(data_3_denoised, [], Fs, ElecName, 'Data 3 denoised in time');

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
