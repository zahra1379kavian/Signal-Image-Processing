%%% Lab8
%% Ali Shahbazi - Zahra Kavain - MohammadReza Safavi - Lab8

%% Q1
clc; clear; close all;
t2 = imread('./S2_Q1_utils/t2.jpg');
t2 = double(t2(:,:,1));

% noisy
t2_noisy = t2 + randn(size(t2))*sqrt(15);
t2_noisy = makeImageBound(t2_noisy);

% kernel
square_kernel = zeros(size(t2));
square_kernel(end/2-1:end/2+2, end/2-1:end/2+2) = 255/16;
t2_fft = fftshift(fft2(t2));
t2_noisy_fft = fftshift(fft2(t2_noisy));
kernel_fft = fftshift(fft2(square_kernel));

t2_noisy_kernel = abs(ifftshift(ifft2(t2_noisy_fft.*kernel_fft)));
t2_noisy_kernel = zscore(t2_noisy_kernel, 0, 'all')*std(t2_noisy, 0, 'all') + mean(t2_noisy, 'all');
t2_noisy_kernel = makeImageBound(t2_noisy_kernel);

figure;
subplot(1,3,1);
imagesc(t2); colorbar; colormap gray; caxis([0 255]);
myPlotProp([], [], 't2 Image', '$x$', '$y$', 'off', '', 13);

subplot(1,3,2);
imagesc(t2_noisy); colorbar; colormap gray; caxis([0 255]);
myPlotProp([], [], 't2 Noisy Image', '$x$', '$y$', 'off', '', 13);

subplot(1,3,3);
imagesc(t2_noisy_kernel); colorbar; colormap gray; caxis([0 255]);
myPlotProp([], [], 't2 de-noised with square kernel', '$x$', '$y$', 'off', '', 13);

% imgaussfilt
t2_noisy_gaussKernel = imgaussfilt(t2_noisy);
t2_noisy_gaussKernel = zscore(t2_noisy_gaussKernel, 0, 'all')*std(t2_noisy, 0, 'all') + mean(t2_noisy, 'all');
t2_noisy_gaussKernel = makeImageBound(t2_noisy_gaussKernel);

figure;
subplot(1,3,1);
imagesc(t2); colorbar; colormap gray; caxis([0 255]);
myPlotProp([], [], 't2 Image', '$x$', '$y$', 'off', '', 13);

subplot(1,3,2);
imagesc(t2_noisy); colorbar; colormap gray; caxis([0 255]);
myPlotProp([], [], 't2 Noisy Image', '$x$', '$y$', 'off', '', 13);

subplot(1,3,3);
imagesc(t2_noisy_gaussKernel); colorbar; colormap gray; caxis([0 255]);
myPlotProp([], [], 't2 de-noised with \textit{imgaussfilt()} kernel', '$x$', '$y$', 'off', '', 13);

figure;
subplot(1,2,1);
imagesc(t2_noisy_kernel); colorbar; colormap gray; caxis([0 255]);
myPlotProp([], [], 't2 de-noised with square kernel', '$x$', '$y$', 'off', '', 13);

subplot(1,2,2);
imagesc(t2_noisy_gaussKernel); colorbar; colormap gray; caxis([0 255]);
myPlotProp([], [], 't2 de-noised with \textit{imgaussfilt()} kernel', '$x$', '$y$', 'off', '', 13);


%% Q2
close all; clear; clc;

t2 = imread('./S2_Q2_utils/t2.jpg');
t2 = double(t2(:,:,1));
h = Gaussian(1,[256, 256]);

g = conv2(t2, h, 'same');
subplot(1,3,1);
imshow(uint8(t2));
subplot(1,3,2);
imshow(uint8(g));

H = fftshift(fft2(h));
G = fftshift(fft2(g));

F = G./H;
f = ifftshift(ifft2(F));

subplot(1,3,3);
imshow(uint8(f));


ng = (g + sqrt(0.001)*randn(256,256));
figure
subplot(1,3,1);
imshow(uint8(t2));
subplot(1,3,2);
imshow(uint8(ng));

nG = fftshift(fft2(double(ng)));

nF = nG./H;
nf = ifftshift(ifft2(nF));

newf = 255*nf./max(nf,[],'all');
subplot(1,3,3);
imshow(uint8(newf));

%% Q3
clc
close all

img = rgb2gray(imread('./S2_Q2_utils/t2.jpg'));
img_resize= (imresize(img,[64 64]));
k= zeros(size(img_resize));
% H= fspecial('gaussian',[3 3]);
h = [0 1 0; 1 2 1; 0 1 0];
% h = Gaussian(1,[3, 3]);
k(1:3,1:3)= h;
D= zeros(size(k,1)*size(k,2),size(k,1)*size(k,2));
idx= 1;


for c= 1:size(img_resize,2) 
    for r= 1:size(img_resize,1)
        k_circshift= circshift(k,[c-1 r-1]);
        D(idx,:)= reshape(k_circshift,1,size(k_circshift,1)*size(k_circshift,2)); 
        idx= idx+1;
    end
end

DF= conv2(img_resize,h,'same');
sigma= 0.05;
gussian_noise= sigma*randn(size(DF));
DF_noisy= DF+ gussian_noise;
D_inverse= pinv(D);


X= reshape(DF_noisy,1,size(DF_noisy,1)*size(DF_noisy,2));
img_hat= D_inverse*X';
img_hat= reshape(img_hat,size(DF_noisy,1),size(DF_noisy,2));

figure
subplot(1,3,1)
imshow(img_resize)
title('Main Image','interpreter','latex')
subplot(1,3,2)
imshow(uint8(DF_noisy))
title('Noisy Image','interpreter','latex')
subplot(1,3,3)
imshow(uint8(img_hat'))
title('Reconstructed Image','interpreter','latex')

figure
imagesc(D)
colorbar
colormap jet
title('D Matrix','interpreter','latex')
%% Q4
close all; clc;

img = rgb2gray(imread('./S2_Q2_utils/t2.jpg'));
img_resize= (imresize(img,[64 64]));

h = [0 1 0; 1 2 1; 0 1 0];
DF= conv2(img_resize,h,'same');
sigma= 0.05;
gussian_noise= sigma*randn(size(DF));
DF_noisy= DF+ gussian_noise;

f = zeros(64,64);
f = reshape(f,1,size(f,1)*size(f,2));
G = reshape(DF_noisy,1,size(DF_noisy,1)*size(DF_noisy,2));
G = G';
f = f';
% img_hat= D_inverse*g';
b=0.01;

for i=1:100
    f = f+b*D'*(G-D*f);
end

img_hat= reshape(f,64,64);

figure
subplot(1,3,1);
imshow(img_resize)

subplot(1,3,2);
imagesc(DF_noisy);
colormap gray
axis equal
axis tight

subplot(1,3,3);
imshow(uint8(img_hat'))

%% functions

function g = Gaussian(sigma, dims)

	rows = dims(1);
	cols = dims(2);
    slices = 1;
    D = 2;
    if length(dims)>2
        slices = dims(3);
        D = 3;
    end
    
	% locate centre pixel.
    % For 256x256, centre is at (129,129)
    % For 257x257, centre is still at (129,129)
	cr = ceil( (rows-1)/2 ) + 1;
	cc = ceil( (cols-1)/2 ) + 1;
    cs = ceil( (slices-1)/2) + 1;
    
	% Set the parameter in exponent 
    a = 1 / (2*sigma^2);
	g = zeros(rows,cols,slices);

    for s = 1:slices
        for c = 1:cols
            for r = 1:rows
                r_sh = r - cr;
                c_sh = c - cc;
                s_sh = s - cs;
                g(r,c,s) = exp( -a * (r_sh^2 + c_sh^2 + s_sh^2) );
            end
        end
    end
    
    g = g / (sqrt(2*pi)*sigma)^D;
end

function im = makeImageBound(im)
    im = round(im);
    im(im>255) = 255;
    im(im<0) = 0;
end

