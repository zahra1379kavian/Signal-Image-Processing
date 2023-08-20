%% Ali Shahbazi - Zahra Kavain - MohammadReza Safavi - Lab9

%% Q1
clc; clear; close all;
t1 = imread('./S3_Q1_utils/thorax_t1.jpg');
t1 = t1(:,:,1);

%% Lung
start_point = [95 95; 100 178];
threshold = [25, 20];
lum = [mean(t1(start_point(1,1)-3:start_point(1,1)+3, start_point(1,2)-3:start_point(1,2)+3), 'all');
    mean(t1(start_point(2,1)-3:start_point(2,1)+3, start_point(2,2)-3:start_point(2,2)+3), 'all')];

mask = findSameNeighbors(t1, start_point, threshold, lum);
final_mask = mask(:,:,1) + mask(:,:,2);
final_mask(final_mask>1) = 1;
final_mask(final_mask<0) = 0;
Overlay(double(t1), final_mask);
myPlotProp([], [], 'Lung Detection by Region Growing', '$x$', '$y$', 'off', '', 15);

%% Liver
start_point = [150 100];
threshold = 20;
lum = mean(t1(start_point(1,1)-3:start_point(1,1)+3, start_point(1,2)-3:start_point(1,2)+3), 'all');

final_mask = findSameNeighbors(t1, start_point, threshold, lum);
final_mask(final_mask>1) = 1;
final_mask(final_mask<0) = 0;
Overlay(double(t1), final_mask);
myPlotProp([], [], 'Liver Detection by Region Growing', '$x$', '$y$', 'off', '', 15);

%% Functions

function mask = findSameNeighbors(t1, start_point, threshold, lum)
    if size(start_point, 1)>1
        mask = zeros(size(t1,1), size(t1,2), 2);
        mask(start_point(1,1), start_point(1,2), 1) = 1;
        mask(start_point(2,1), start_point(2,2), 2) = 1;
    else
        mask = zeros(size(t1,1), size(t1,2), 1);
        mask(start_point(1,1), start_point(1,2), 1) = 1;
    end
    for point=1:size(start_point, 1)
        s = 1;
        while(s ~= 0)
            s = 0;
            [row, col] = find(squeeze(mask(:,:,point))==1);
            for i=1:numel(row)
                % check right
                if mask(row(i),col(i)+1,point) == 0
                    if (t1(row(i),col(i)+1) < lum(point)+threshold(point)) && (t1(row(i),col(i)+1) > lum(point)-threshold(point))
                        mask(row(i),col(i)+1,point) = 1;
                        s = 1;
                    else
                        mask(row(i),col(i)+1,point) = -1;
                    end
                end

                % check left
                if mask(row(i),col(i)-1,point) == 0
                    if (t1(row(i),col(i)-1) < lum(point)+threshold(point)) && (t1(row(i),col(i)-1) > lum(point)-threshold(point))
                        mask(row(i),col(i)-1,point) = 1;
                        s = 1;
                    else
                        mask(row(i),col(i)-1,point) = -1;
                    end
                end

                % check up
                if mask(row(i)-1,col(i),point) == 0
                    if (t1(row(i)-1,col(i)) < lum(point)+threshold(point)) && (t1(row(i)-1,col(i)) > lum(point)-threshold(point))
                        mask(row(i)-1,col(i),point) = 1;
                        s = 1;
                    else
                        mask(row(i)-1,col(i),point) = -1;
                    end
                end

                % check down
                if mask(row(i)+1,col(i),point) == 0
                    if (t1(row(i)+1,col(i)) < lum(point)+threshold(point)) && (t1(row(i)+1,col(i)) > lum(point)-threshold(point))
                        mask(row(i)+1,col(i),point) = 1;
                        s = 1;
                    else
                        mask(row(i)+1,col(i),point) = -1;
                    end
                end
            end
        end
    end
end









