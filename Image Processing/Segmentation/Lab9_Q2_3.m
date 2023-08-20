clc
close all
clear

% Question 2

img1= imread('t1.jpg');
img2= imread('t2.jpg');
img3= imread('pd.jpg');


%I= cat(1,img1,img2,img3);
img= zeros(size(img1,1)*size(img1,2),9);
count= 1;

for i= 1:size(img1,1)
    for j= 1:size(img1,2)
       img(count,:)= [squeeze(img1(i,j,:))' squeeze(img2(i,j,:))' squeeze(img3(i,j,:))']; 
       count= count+1; 
    end
end

k= 6;
[idx,C] = kmeans(img,k);

for i= 1:size(img1,1)
   idx2(i,:)= idx((i-1)*size(img1,2)+1:i*size(img1,2));
end

cluster= zeros(size(img1,1),size(img1,2),k);

for t= 1:k
for i= 1:size(img1,1)
    for j= 1:size(img1,2)
        if idx2(i,j)==t
           cluster(i,j,t)= 1; 
        end
    end
end
end

figure
subplot(2,3,1)
imagesc(cluster(:,:,1))
subplot(2,3,2)
imagesc(cluster(:,:,2))
subplot(2,3,3)
imagesc(cluster(:,:,3))
subplot(2,3,4)
imagesc(cluster(:,:,4))
subplot(2,3,5)
imagesc(cluster(:,:,5))
subplot(2,3,6)
imagesc(cluster(:,:,6))
colormap gray

%%
clc
% Question 3

num_of_clusters= 6;
x= size(img,1);
centers= randi(x,1,num_of_clusters);
[clusters, centers] = k_mean_func(img, num_of_clusters, centers);

I= zeros(size(img1,1),size(img1,2),num_of_clusters);

for i= 1:size(img1,1)
   idx2(i,:)= clusters((i-1)*size(img1,2)+1:i*size(img1,2));
end

for t= 1:num_of_clusters
for i= 1:size(img1,1)
    for j= 1:size(img1,2)
        if idx2(i,j)==t
           I(i,j,t)= 1; 
        end
    end
end
end

figure
subplot(2,3,1)
imagesc(I(:,:,1))
subplot(2,3,2)
imagesc(I(:,:,2))
subplot(2,3,3)
imagesc(I(:,:,3))
subplot(2,3,4)
imagesc(I(:,:,4))
subplot(2,3,5)
imagesc(I(:,:,5))
subplot(2,3,6)
imagesc(I(:,:,6))
colormap gray


function [clusters, centers] = k_mean_func(data, num_of_clusters, centers)
    previous_cluster = firstCluster(data, num_of_clusters, centers); count= 0;
    while(1)
        count = count +1;
        count
        [new_cluster, new_centers] = meanCluster(data, previous_cluster, num_of_clusters);
        if (max(abs(new_cluster-previous_cluster)) < 1)
        	break;
        end
        previous_cluster = new_cluster;
    end
    clusters = new_cluster;
    centers = new_centers;
end

function first = firstCluster(data, num_of_clusters, centers)
    size_data = size(data);
    first = zeros(1, size_data(2));
    d = zeros(1,num_of_clusters);
    for i=1:size(data,1)
        for j=1:num_of_clusters
            d(j)= norm(data(i,:)-data(centers(j),:));
        end
        [d_min, clusterNum] = min(d);
        first(i) = clusterNum;
    end
end

function [new_cluster, new_centers] = meanCluster(data, previous_cluster, num_of_clusters)
    size_cluster = length(previous_cluster);
    sum_cluster = zeros(size(data,2),num_of_clusters);
    n = zeros(1,num_of_clusters);
    for i=1:size_cluster
        for j=1:num_of_clusters
            if(previous_cluster(i)==j)
                sum_cluster(:,j) = sum_cluster(:,j) + data(i,:)';
                n(j) = n(j) + 1;
            end
        end
    end
    
    new_centers = zeros(size(data,2),num_of_clusters);
    for j=1:num_of_clusters
        new_centers(:,j) = sum_cluster(:,j) ./ n(j);
    end
    
    new_cluster = zeros(1,size_cluster);
    d = zeros(1,num_of_clusters);
    for i=1:size_cluster
        for j=1:num_of_clusters
            d(j)= norm(data(i,:)-new_centers(:,j)');
        end
        [d_min, clusterNum] = min(d);
        new_cluster(i) = clusterNum;
    end
end







