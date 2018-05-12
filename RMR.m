I = imread('station.png');
figure,imshow(I);
[m,n] = size(I);

F = fft2(I);
figure
imshow(uint8(F));
%% 将频谱压缩，居中
H = log(1+abs(F));
Hc = fftshift(H);
figure
imshow(uint8(Hc)); 
%% 用canny算子将压缩居中后的频谱图进行边缘检测，二值化
T = graythresh(Hc);
bw=edge(Hc, 'canny', T);
figure
imshow(bw);
%% 对二值化后的频谱图进行radon变换
theta = 1:180;
R = radon(bw, theta);
figure
imshow(R);
%% 计算出通过radon变换求出的模糊角度
MAX = max(max(R));
[m, n] = find(R == MAX);
[M,N] = size(Hc);
beita = atan(tan(n*pi/180)*M/N)*180/pi;

PSF = fspecial('motion',16,12);
fr2= deconvwnr(I,PSF);
figure
imshow(fr2);