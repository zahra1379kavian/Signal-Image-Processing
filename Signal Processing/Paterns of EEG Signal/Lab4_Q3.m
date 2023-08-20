close all
clc
clear

load('FiveClass_EEG.mat');
%%
% Filter Parameter
fs = 256; % Sampling Frequency
N = 4; % Order
Apss = 1; % Passband Ripple (dB)

% Delta Filter
Fpass1 = 1; % First Passband Frequency
Fpass2 = 4; % Second Passband Frequency
Delta_X= bandpass_filter(Fpass1,Fpass2,fs,N,Apss,X);

% Theta Filter
Fpass1 = 4; % First Passband Frequency
Fpass2 = 8; % Second Passband Frequency
Theta_X= bandpass_filter(Fpass1,Fpass2,fs,N,Apss,X);

% Alpha Filter
Fpass1 = 8; % First Passband Frequency
Fpass2 = 13; % Second Passband Frequency
Alpha_X= bandpass_filter(Fpass1,Fpass2,fs,N,Apss,X);

% Beta Filter
Fpass1 = 13; % First Passband Frequency
Fpass2 = 30; % Second Passband Frequency
Beta_X= bandpass_filter(Fpass1,Fpass2,fs,N,Apss,X);
%%
clc
% plot raw and filtered signal
t= 0:1/fs:5-1/fs;

figure
subplot(5,1,1)
plot(t,X(1:5*fs,1))
title('Raw Signal','Interpreter','latex')

subplot(5,1,2)
plot(t,Delta_X(1:5*fs,1))
title('Delta Signal','Interpreter','latex')

subplot(5,1,3)
plot(t,Theta_X(1:5*fs,1))
title('Theta Signal','Interpreter','latex')

subplot(5,1,4)
plot(t,Alpha_X(1:5*fs,1))
title('Alpha Signal','Interpreter','latex')

subplot(5,1,5)
plot(t,Beta_X(1:5*fs,1))
title('Beta Signal','Interpreter','latex')
xlabel('time (s)','Interpreter','latex')

%%
clc
% Extract trial

for i=1:200
 Delta_Trials(:,:,i) = Delta_X(trial(i): trial(i)+256*10,:);  % TimePoint*Channel*Trial
end

for i=1:200
 Theta_Trials(:,:,i) = Theta_X(trial(i): trial(i)+256*10,:);  % TimePoint*Channel*Trial
end

for i=1:200
 Alpha_Trials(:,:,i) = Alpha_X(trial(i): trial(i)+256*10,:);  % TimePoint*Channel*Trial
end


for i=1:200
 Beta_Trials(:,:,i) = Beta_X(trial(i): trial(i)+256*10,:);  % TimePoint*Channel*Trial
end

%%
clc
% Power calculation

Delta_Trials_square= Delta_Trials.^2;
Theta_Trials_square= Theta_Trials.^2;
Beta_Trials_square= Beta_Trials.^2;
Alpha_Trials_square= Alpha_Trials.^2;

%%
clc
class1_trial= find(y==1);
class2_trial= find(y==2);
class3_trial= find(y==3);
class4_trial= find(y==4);
class5_trial= find(y==5);

Delta_X_Avg= extract_class(Delta_Trials_square,class1_trial,class2_trial,class3_trial,class4_trial,class5_trial);
Theta_X_Avg= extract_class(Theta_Trials_square,class1_trial,class2_trial,class3_trial,class4_trial,class5_trial);
Beta_X_Avg= extract_class(Beta_Trials_square,class1_trial,class2_trial,class3_trial,class4_trial,class5_trial);
Alpha_X_Avg= extract_class(Alpha_Trials_square,class1_trial,class2_trial,class3_trial,class4_trial,class5_trial);
%%
clc
% smooth signal
newwin= ones(1,200)/sqrt(200);

for i= 1:size(Delta_X_Avg,2) % each channel
    for j= 1:size(Delta_X_Avg,3) % each class
       Delta_X_Avg_Filt(:,i,j)= conv(squeeze(Delta_X_Avg(:,i,j)),newwin,'same'); 
       Theta_X_Avg_Filt(:,i,j)= conv(squeeze(Theta_X_Avg(:,i,j)),newwin,'same'); 
       Beta_X_Avg_Filt(:,i,j)= conv(squeeze(Beta_X_Avg(:,i,j)),newwin,'same'); 
       Alpha_X_Avg_Filt(:,i,j)= conv(squeeze(Alpha_X_Avg(:,i,j)),newwin,'same'); 
    end
end
%%
clc
% Last part :)
selected_channel= 16;
t= 0:1/fs:10;

figure
for i=1:5
    subplot(5,1,i)
    plot(t,Delta_X_Avg_Filt(:,selected_channel,i))
    hold on
    xline(3,'--r')
    hold off
    if i==1; title('Delta Band','interpreter','latex'); end
    if i==5; xlabel('time (s)'); end
    ylim([0 60])
end



figure
for i=1:5
   subplot(5,1,i)
   plot(t,Theta_X_Avg_Filt(:,selected_channel,i)) 
   hold on
   xline(3,'--r')
   hold off
   if i==1; title('Theta Band','interpreter','latex'); end
   if i==5; xlabel('time (s)'); end
   ylim([0 300])
end



figure
for i=1:5
    subplot(5,1,i)
    plot(t,Beta_X_Avg_Filt(:,selected_channel,i))
    hold on
    xline(3,'--r')
    hold off
    if i==1; title('Beta Band','interpreter','latex'); end
    if i==5; xlabel('time (s)'); end
    ylim([0 1000])
end


figure
for i=1:5
   subplot(5,1,i)
   plot(t,Alpha_X_Avg_Filt(:,selected_channel,i))   
   hold on
   xline(3,'--r')
   hold off
   if i==1; title('Alpha Band','interpreter','latex'); end
   if i==5; xlabel('time (s)'); end
   ylim([0 400])
end


%%
% Function

function Filtered_X= bandpass_filter(Fpass1,Fpass2,fs,N,Apass,X)
% Construct an FDESIGN object and call its CHEBY1 method.
h = fdesign.bandpass('N,Fp1,Fp2,Ap', N, Fpass1, Fpass2,Apass, fs);
Hd = design(h, 'cheby1');
for c=1:30
 Filtered_X(:,c) = filter(Hd,X(:,c));
end
end


function X_Avg= extract_class(Power_sig,class1_trial,class2_trial,class3_trial,class4_trial,class5_trial)
X_Avg(:,:,1)= mean(Power_sig(:,:,class1_trial),3);
X_Avg(:,:,2)= mean(Power_sig(:,:,class2_trial),3);
X_Avg(:,:,3)= mean(Power_sig(:,:,class3_trial),3);
X_Avg(:,:,4)= mean(Power_sig(:,:,class4_trial),3);
X_Avg(:,:,5)= mean(Power_sig(:,:,class5_trial),3);

end
