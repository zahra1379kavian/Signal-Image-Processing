clc
close all
clear

img1= imread('./S3_Q2_utils/t1.jpg');
img2= imread('./S3_Q2_utils/t2.jpg');
img3= imread('./S3_Q2_utils/pd.jpg');


%I= cat(1,img1,img2,img3);
img= zeros(size(img1,1)*size(img1,2),9);
count= 1;

for i= 1:size(img1,1)
    for j= 1:size(img1,2)
       img(count,:)= [squeeze(img1(i,j,:))' squeeze(img2(i,j,:))' squeeze(img3(i,j,:))']; 
       count= count+1; 
    end
end



num_of_clusters= 6;
x= size(img,1);
centers= randi(x,1,num_of_clusters);
%%
clc
new_img= find_cluster_group(img(centers,:), img);
new_center= new_center_func(new_img,num_of_clusters,img);



function new_center= new_center_func(new_img,num_of_clusters,img)
new_center= zeros(num_of_clusters,size(new_img,2)-1);

for i= 1:num_of_clusters
   label= find(new_img(:,10)==i);
   if ~isempty(label)
   new_center(i,:)= mean(img(label,:),1);
   else
      new_center(i,:)= img(randi(size(img,1)),:); 
   end
end
end



function new_img= find_cluster_group(centers, img)
dist= zeros(1,size(centers,1));
new_img= zeros(size(img,1),size(img,2)+1);
new_img(:,1:9)= img;

for i= 1:size(img,1) % each sample
   for  j= 1:size(centers,1)
       dist(j)= norm(centers(j,:)-img(i,:));
       [~,cluster_um]= min(dist);
       new_img(i,10)= cluster_um;
   end  
end
end


