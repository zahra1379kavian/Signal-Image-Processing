close all
clc
clear

load('ElecPosXYZ.mat')
N_Electrode = 21;
%% part a,b,c
clc
%Forward Matrix
ModelParams.R = [8 8.5 9.2] ;
ModelParams.Sigma = [3.3e-3 8.25e-5 3.3e-3];
ModelParams.Lambda = [.5979 .2037 .0237];
ModelParams.Mu = [.6342 .9364 1.0362];

Resolution = 1 ;
[LocMat,GainMat] = ForwardModel_3shell(Resolution, ModelParams) ;

save LeadFieldMatrix_parta GainMat
N_Dipole = size(LocMat,2);

figure
scatter3(LocMat(1,:),LocMat(2,:),LocMat(3,:),'black','LineWidth',2)
xlabel('X')
ylabel('Y')
zlabel('Z')

hold on

for i = 1:N_Electrode
    ElecPoision.X{1, i} = ModelParams.R(3)*ElecPos{1, i}.XYZ(1);
    ElecPoision.Y{1, i} = ModelParams.R(3)*ElecPos{1, i}.XYZ(2);
    ElecPoision.Z{1, i} = ModelParams.R(3)*ElecPos{1, i}.XYZ(3);
    ElecName{1, i} = ElecPos{1, i}.Name;
end

scatter3(cell2mat(ElecPoision.X),cell2mat(ElecPoision.Y),cell2mat(ElecPoision.Z),'g','LineWidth',2)
title('Dipole \& Electrodes Location','interpreter','latex')
text(cell2mat(ElecPoision.X),cell2mat(ElecPoision.Y),cell2mat(ElecPoision.Z),ElecName,'Color','b','FontSize',10);

hold on

%random_dipole = randi(N_Dipole);
%random_dipole = 200; % on the surface
%random_dipole = 1000; % in depth
random_dipole= 283; % Temporal lobe
random_dipole_loc = LocMat(:,random_dipole);
scatter3(random_dipole_loc(1),random_dipole_loc(2),random_dipole_loc(3),'k*','LineWidth',3)

hold on

random_dipole_dir = random_dipole_loc/norm(random_dipole_loc);
plot3([random_dipole_loc(1) random_dipole_loc(1)+random_dipole_dir(1)],...
    [random_dipole_loc(2) random_dipole_loc(2)+random_dipole_dir(2)],...
    [random_dipole_loc(3) random_dipole_loc(3)+random_dipole_dir(3)],'m-','LineWidth',2)
%% part d
load('Interictal')
Dipole_potential = Interictal(10,:);
Q = random_dipole_dir*Dipole_potential;
M = GainMat(:,[random_dipole*3-2, random_dipole*3-1,random_dipole*3])*Q;

figure
for i = 1:N_Electrode
    Y(i) = i*60;
    plot(M(i,:)+Y(i),'LineWidth',1)
    hold on
end
yticks(Y)
yticklabels(ElecName)
%% part e
for i = 1:N_Electrode
    [~,locs] = findpeaks(M(i,:),'MinPeakHeight',0.6*max(M(i,:)));
    for j = 1:length(locs)
        m_peak(7*(j-1)+1:7*j) = M(i,locs(j)-3:locs(j)+3);
    end
    m__peak_AVG(i) = mean(m_peak);
end

figure;
Display_Potential_3D(ModelParams.R(3),m__peak_AVG);
%% part f
% MNE
IN = eye(size(N_Electrode,1));
alpha = 0.5;
Q_hat_MNE = GainMat'*pinv(GainMat*GainMat'+alpha.*IN)*M;


% WMNE
omega = zeros(1,N_Dipole);
for i = 1:N_Dipole
   for j = 1:N_Electrode
      omega(i) = omega(i) + GainMat(j,3*i-2:3*i)*GainMat(j,3*i-2:3*i)'; 
   end
end
omega = omega.^0.5;
W1 = [omega;omega;omega];
W = diag(W1(:));

Q_hat_WMNE = pinv(W'*W)*GainMat'*pinv(GainMat*pinv(W'*W)*GainMat'+alpha.*IN)*M;
%% part g
temp_win = reshape(1:length(GainMat),[3,length(GainMat)/3]);
max_QMNE = max(Q_hat_MNE,[],2);
Amp_MNE= sum(max_QMNE(temp_win).^2).^0.5;
[Amp_dipole_MNE,I_MNE] = max(Amp_MNE);
dir_dipole_MNE = max_QMNE(3*I_MNE-2:3*I_MNE)/Amp_dipole_MNE;


%%
max_QWMNE = max(Q_hat_WMNE,[],2);
Amp_WMNE=sum(max_QWMNE(temp_win).^2).^0.5;
[Amp_dipole_WMNE,I_WMNE] = max(Amp_WMNE);
dir_dipole_WMNE = max_QWMNE(3*I_WMNE-2:3*I_WMNE)/Amp_dipole_WMNE;

figure
scatter3(LocMat(1,:),LocMat(2,:),LocMat(3,:),'black','LineWidth',2)
xlabel('X')
ylabel('Y')
zlabel('Z')
hold on
scatter3(cell2mat(ElecPoision.X),cell2mat(ElecPoision.Y),cell2mat(ElecPoision.Z),'g','LineWidth',2)
title('Dipole \& Electrodes Location','interpreter','latex')
text(cell2mat(ElecPoision.X),cell2mat(ElecPoision.Y),cell2mat(ElecPoision.Z),ElecName,'Color','b','FontSize',10);
colorbar
hold on
scatter3(LocMat(1,I_MNE),LocMat(2,I_MNE),LocMat(3,I_MNE),'k*','LineWidth',3)
text(LocMat(1,I_MNE),LocMat(2,I_MNE),LocMat(3,I_MNE),'MNE','Color','b')
hold on
plot3([LocMat(1,I_MNE) LocMat(1,I_MNE)+dir_dipole_MNE(1)],...
    [LocMat(2,I_MNE) LocMat(2,I_MNE)+dir_dipole_MNE(2)],...
    [LocMat(3,I_MNE) LocMat(3,I_MNE)+dir_dipole_MNE(3)],'m-','LineWidth',2)
hold on
scatter3(LocMat(1,I_WMNE),LocMat(2,I_WMNE),LocMat(3,I_WMNE),'k*','LineWidth',3)
text(LocMat(1,I_WMNE),LocMat(2,I_WMNE),LocMat(3,I_WMNE),'WMNE','Color','b')
hold on
plot3([LocMat(1,I_WMNE) LocMat(1,I_WMNE)+dir_dipole_WMNE(1)],...
    [LocMat(2,I_WMNE) LocMat(2,I_WMNE)+dir_dipole_WMNE(2)],...
    [LocMat(3,I_WMNE) LocMat(3,I_WMNE)+dir_dipole_WMNE(3)],'m-','LineWidth',2)

%% part h

Q_real = zeros(length(GainMat),length(Interictal));
Q_real(random_dipole*3-2:random_dipole*3,:) = Q;


% MNE
MSE_MNE = mse(Q_real,Q_hat_MNE);
d_MNE = norm(LocMat(:,I_MNE) - LocMat(:,random_dipole))
Dif_dir_MNE = dir_dipole_MNE - random_dipole_dir

% WMNE
MSE_WMNE = mse(Q_real,Q_hat_WMNE);
d_WMNE = norm(LocMat(:,I_WMNE) - LocMat(:,random_dipole))
Dif_dir_WMNE = dir_dipole_WMNE - random_dipole_dir

