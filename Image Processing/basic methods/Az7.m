close all
clc
clear 

img = imread('./S1_Q4_utils/ct.jpg');
img= img(:,:,1);
img_fourier= fftshift(fft2(double(img)));
img_fourier_padd= zeros(size(img_fourier,1)+20,size(img_fourier,1)+40);
img_fourier_padd(21:end,41:end)= img_fourier;
img_fourier_padd_inverse= ifft2(img_fourier_padd);



clc
img_fourier_padd= zeros(size(img_fourier,1)+40,size(img_fourier,1)+40);
img_fourier_padd(1:end-40,1:end-40)= img;

kernel_right= zeros(size(img_fourier_padd));
for i= 1:size(kernel_right,1)
    if i~= size(kernel_right,1)
        kernel_right(i,i+1)= 1;
    end
end

kernel_bellow= zeros(size(img_fourier_padd));
for i= 1:size(kernel_bellow,1)
    if i~= 1
        kernel_bellow(i,i-1)= 1;
    end
end

kernel= kernel_right^20*kernel_bellow^20;
kernel_fft= fftshift(fft2(kernel));

figure
imagesc(log(abs(kernel_fft)))
%%
clear all
clc

img = imread('./S1_Q4_utils/ct.jpg');
img= img(:,:,1);
angle= 30;
img_rotate= imrotate(img,angle);

figure
subplot(1,3,1)
img_fft= fftshift(fft2(img));
imagesc(log(abs(img_fft)))
subplot(1,3,2)
img_rotate_fft= fftshift(fft2(img_rotate));
imagesc(log(abs(img_rotate_fft)))
subplot(1,3,3)
img_fft_rotate= imrotate(img_fft,angle);
imagesc(log(abs(img_fft_rotate)))
colormap jet

figure
imagesc(abs(ifft2(img_rotate_fft)))



