%读取图像
X=imread('assets/rotation_noise.tif'); 
X=rgb2gray(X);
%读取图像尺寸
[m,n]=size(X); 

Y=dct2(X); 
I=zeros(m,n);
%高频屏蔽
I(1:m/3,1:n/3)=1; 
Ydct=Y.*I;
%逆DCT变换
Y=uint8(idct2(Ydct)); 
%结果输出
subplot(122);
imshow(Y);