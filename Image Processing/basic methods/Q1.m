%% Ali Shahbazi - Zahra Kavain - MohammadReza Safavi - Lab7

%% Q1
clc; clear; close all;
t1 = imread('./S1_Q1_utils/t1.jpg');
t1 = t1(:,:,1);
imshow(t1);
X_fft = myFFT(t1(128,:));
figure;
subplot(1,2,1);
plot(abs(X_fft), 'linewidth', 1.5);
myPlotProp([1 128], [], 'Amplitude of DFT', '', '$|P(f)|$', 'off', '', 14);
subplot(1,2,2);
plot(unwrap(angle(X_fft)*180/pi), 'linewidth', 1.5);
myPlotProp([1 128], [], 'Unwrap Phase of DFT', '', '$\angle P(f)$', 'off', '', 14);

%%
X_fft2 = fftshift(fft2(double(t1)));
figure;
subplot(1,2,1);
imshow(t1);
myPlotProp([], [], 'Original Image', '$x$', '$y$', 'off', '', 14);
subplot(1,2,2);
imagesc(log(abs(X_fft2))); axis equal; axis tight;
myPlotProp([], [], '2-D DFT of Image', '$x$', '$y$', 'off', '', 14);

%% Q2
[X, Y] = ndgrid(1:256);
R = 15;
G = ((X-128).^2 + (Y-128).^2) < R^2;
F = zeros(256, 256);
F(100, 50) = 1; F(120, 48) = 2;
conv_im = conv2(abs(ifftshift(ifft2(G))), abs(ifftshift(ifft2(F))));
pd = imread('./S1_Q2_utils/pd.jpg');
pd = pd(:,:,1);

figure;
subplot(1,3,1);
imagesc(abs(ifftshift(ifft2(G)))); axis equal; axis tight; colormap gray;
subplot(1,3,2);
imagesc(abs(ifftshift(ifft2(F)))); axis equal; axis tight; colormap gray;
subplot(1,3,3);
imagesc(conv_im); axis equal; axis tight; colormap gray;

figure;
imagesc(conv2(pd, G)); axis equal; axis tight; colormap gray;

%% Q3
ct = imread('./S1_Q4_utils/ct.jpg');
ct = ct(:,:,1);
ct_fft2 = fftshift(fft2(double(ct)));
% figure;imagesc(abs(ct_fft2)); axis equal; axis tight; colormap gray;
% ct_fft2_zero_pad = zeros(size(ct_fft2,1)+40, size(ct_fft2,2)+40);
% ct_fft2_zero_pad(21:end-20, 21:end-20) = ct_fft2;
% figure;imagesc(abs(ct_fft2_zero_pad)); axis equal; axis tight; colormap gray;
% ct_zoom = abs((ifft2(ct_fft2_zero_pad)));
ct_zoom = abs(ifft2(ct_fft2, 300, 300));

figure;
subplot(1,2,1);
imagesc(ct); axis equal; axis tight; colormap gray;
subplot(1,2,2);
imagesc(ct_zoom(23:end-23, 23:end-23)); axis equal; axis tight; colormap gray;

%% Functions

function Y = myFFT(chan)
%     L = length(chan);
%     n = 2^nextpow2(L);
%     f = (Fs*(2:(n/2))/n)';
%     X = fft(chan, n)/n;
    X = fft(chan);
    Y = 2*X(1:end/2);
end
