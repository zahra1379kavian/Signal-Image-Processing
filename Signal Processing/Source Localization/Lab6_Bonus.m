%%%%%%%% Lab 6 %%%%%%%%%%

%% Bonus
close all; clear; clc;
load('ElecPosXYZ') ;
load('Interictal.mat');
%Forward Matrix
ModelParams.R = [8 8.5 9.2] ; % Radius of diffetent layers
ModelParams.Sigma = [3.3e-3 8.25e-5 3.3e-3]; 
ModelParams.Lambda = [.5979 .2037 .0237];
ModelParams.Mu = [.6342 .9364 1.0362];

Resolution = 1 ;
[LocMat,GainMat] = ForwardModel_3shell(Resolution, ModelParams) ;

rnd = randi(1317);

random_dipole_loc = LocMat(:,rnd);
random_dipole_dir = random_dipole_loc/norm(random_dipole_loc);
Dipole_potential = Interictal(10,:);
Q = random_dipole_dir*Dipole_potential;
M = GainMat(:,[3*(rnd-1)+1, 3*(rnd-1)+1, 3*(rnd-1)+1])*Q;
C = GainMat;
vals = zeros(1317,1);
dips = zeros(4,50);
for t=1:50
    for i=1:1317
        [Aeq, beq] = calcMats(1317, i);
        d = M(:,t);
        q = lsqlin(C,d,Aeq,beq);
        vals(i)=norm(C*q-d,2);
    end
    [~, index] = min(vals);
    [Aeq, beq] = calcMats(1317, index);
    d = M(:,t);
    q = lsqlin(C,d,Aeq,beq);
    dips(1,t)=index;
    dips(2:4,t)=q(3*(index-1)+1:3*(index-1)+3);
end

function [Aeq, beq] = calcMats(P, ind)
    Aeq = eye(3*P);
    Aeq(3*(ind-1)+1, 3*(ind-1)+1) = 0;
    Aeq(3*(ind-1)+2, 3*(ind-1)+2) = 0;
    Aeq(3*(ind-1)+3, 3*(ind-1)+3) = 0;
    beq = zeros(3*P,1);
end

