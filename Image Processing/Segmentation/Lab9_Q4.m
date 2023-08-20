%% Lab 9

%% Q4
close all; clear; clc;

pd = imread('./S3_Q2_utils/pd.jpg');
t1 = imread('./S3_Q2_utils/pd.jpg');
t2 = imread('./S3_Q2_utils/pd.jpg');

im = zeros(249,213,9);
im(:,:,1:3) = pd(:,:,:);
im(:,:,4:6) = t1(:,:,:);
im(:,:,7:9) = t2(:,:,:);

% im = pd;
imd = double(im);

fm = reshape(imd, [249*213,9]);

[centers,U] = fcm(fm,6);
clc;

maxU = max(U);
index1 = find(U(1,:) == maxU);
index2 = find(U(2,:) == maxU);
index3 = find(U(3,:) == maxU);
index4 = find(U(4,:) == maxU);
index5 = find(U(5,:) == maxU);
index6 = find(U(6,:) == maxU);

c1 = fm;
% for c=1:1
    for i=1:249*213
        if(isempty(find(index1==i, 1)))
           c1(i,:)=0; 
        end
    end
% end
c11 = reshape(c1, [249, 213, 9]);


c2 = fm;
% for c=1:1
    for i=1:249*213
        if(isempty(find(index2==i, 1)))
           c2(i,:)=0; 
        end
    end
% end
c21 = reshape(c2, [249, 213, 9]);

c3 = fm;
% for c=1:1
    for i=1:249*213
        if(isempty(find(index3==i, 1)))
           c3(i,:)=0; 
        end
    end
% end

c31 = reshape(c3, [249, 213, 9]);

c4 = fm;
% for c=1:1
    for i=1:249*213
        if(isempty(find(index4==i, 1)))
           c4(i,:)=0; 
        end
    end
% end
c41 = reshape(c4, [249, 213, 9]);

c5 = fm;
% for c=1:1
    for i=1:249*213
        if(isempty(find(index5==i, 1)))
           c5(i,:)=0; 
        end
    end
% end
c51 = reshape(c5, [249, 213, 9]);

c6 = fm;
% for c=1:1
    for i=1:249*213
        if(isempty(find(index6==i, 1)))
           c6(i,:)=0; 
        end
    end
% end
c61 = reshape(c6, [249, 213, 9]);



figure
subplot(2,3,1);
imshow(uint8(c11(:,:,1)));

subplot(2,3,2);
imshow(c21(:,:,1));

subplot(2,3,3);
imshow(c31(:,:,1));

subplot(2,3,4);
imshow(c41(:,:,1));

subplot(2,3,5);
imshow(c51(:,:,1));

subplot(2,3,6);
imshow(c61(:,:,1));











