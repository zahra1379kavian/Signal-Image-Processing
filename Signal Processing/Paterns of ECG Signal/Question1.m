close all
clc
clear

%%% question 1

load('normal');
fs= 250;
Time= normal(:,1); sig= normal(:,2); segmentLength = 5*fs; overlap= 4*fs;

%stft(ECG_sig,fs); 
%%%%%%%%%%%%%%%%%%%% Power Spectrume Signal %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t0= 2;
figure
subplot(2,1,1)
plot(Time(t0*fs:fs*(t0+7)),sig(t0*fs:fs*(t0+7)))
xlabel('Time (s)','Interpreter','latex')
xlim([t0 t0+7])
title('Raw Signal','Interpreter','latex')
subplot(2,1,2)
[pxx,w]= pwelch(sig(t0*fs:fs*(t0+7)),segmentLength,overlap,[],fs);
plot(w,10*log10(pxx))
title('Power Spectogram Density Clean ECG Signal','Interpreter','latex')
xlabel('frequency (Hz)','Interpreter','latex')
ylabel('PSD (dB/Hz)','Interpreter','latex')
xlim([0 120])



t0= 240;
figure
subplot(2,1,1)
plot(Time(t0*fs:fs*(t0+7)),sig(t0*fs:fs*(t0+7)))
xlabel('Time (s)','Interpreter','latex')
xlim([t0 t0+7])
title('Raw Signal','Interpreter','latex')
subplot(2,1,2)
[pxx,w]= pwelch(sig(t0*fs:fs*(t0+7)),segmentLength,overlap,[],fs);
plot(w,10*log10(pxx))
title('Power Spectogram Density Noisy ECG Signal','Interpreter','latex')
xlabel('frequency (Hz)','Interpreter','latex')
ylabel('PSD (dB/Hz)','Interpreter','latex')
xlim([0 120])


figure
obw(sig(1*fs:fs*(1+7)),fs)
%%
%%%%%%%%%%%%%%%%%%%%%%% Filter Signal %%%%%%%%%%%%%%%%%%%%%%%%%%
clc; close all;
ECG_sig= sig(1:4*60*fs);
Noisy_sig= sig(4*60*fs+1:5*60*fs);
Fpass1=1; Fpass2=50;

% Filter Noisy Signal
d = designfilt('bandpassiir','FilterOrder',50, ...
    'HalfPowerFrequency1',Fpass1,'HalfPowerFrequency2',Fpass2, ...
    'SampleRate',fs);

Filtered_ECG_sig = filter(d,ECG_sig);
Filtered_Noisy_sig = filter(d,Noisy_sig);

% frequency response 
fvtool(d)
% impulse response
impz(d,50)

%%
% do on noisy singnal
t= 2:1/fs:12;
figure
subplot(2,1,1)
plot(t,Noisy_sig(2*fs:12*fs))
xlabel('Time (s)','interpreter','latex')
title('Noisy Signal','interpreter','latex')
subplot(2,1,2)
plot(t, Filtered_Noisy_sig(2*fs:12*fs))
xlabel('Time (s)','interpreter','latex')
title('After Filtering','interpreter','latex')
%%
% do on ECG singnal
t= 2:1/fs:12;
figure
subplot(2,1,1)
plot(t,ECG_sig(2*fs:12*fs))
xlabel('Time (s)','interpreter','latex')
title('ECG Signal','interpreter','latex')
subplot(2,1,2)
plot(t, Filtered_ECG_sig(2*fs:12*fs))
xlabel('Time (s)','interpreter','latex')
title('After Filtering','interpreter','latex')
 
%%
% power spectrum noisy signal after filtering
clc
[pxx_noisy,w]= pwelch(Filtered_Noisy_sig-mean(Filtered_ECG_sig.^2),segmentLength,overlap,[],fs);

figure
plot(w,10*log10(pxx_noisy))
title('Power Spectogram Density Noisy ECG Signal','Interpreter','latex')
xlabel('frequency (Hz)','Interpreter','latex')
ylabel('PSD (dB/Hz)','Interpreter','latex')
xlim([0 120])

