%%
%��ȡͼ��
close all;
clear all;
filename = 'motion_blur.jpg';
I = imread(filename);
figure
imshow(uint8(I));
title('ԭͼ');
%%
%ģ������
h=fspecial('sobel');
img_double=double(I);
J=conv2(img_double,h,'same');
IP=abs(fft2(J));
S=fftshift(real(ifft2(IP)));
figure
plot(S);
%%
%ģ���Ƕ�
F = fft2(I);
H = log(1+abs(F));
Hc = fftshift(H);
T = graythresh(Hc);
bw=edge(Hc, 'canny', T);
theta = 1:180;
R = radon(bw, theta);
MAX = max(max(R));
[m, n] = find(R == MAX);
[M,N] = size(Hc);
beita = atan(tan(n*pi/180)*M/N)*180/pi;
%%
%ά���˲�
PSF = fspecial('motion',16,beita);%ģ��������Ҫ��ģ������δ��뿴ͼ�ó�
I0= deconvwnr(I,PSF,0.005);%�������Ҫ����
figure
imshow(IO);