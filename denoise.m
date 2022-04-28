function rec = denoise(Img, K0)
[h, w] = size(Img);
%二维快速傅立叶变换
ff = fft2(Img);

dx = 1;
dy = 1;
KX0 = (mod(1/2 + (0:(h-1))/h, 1) - 1/2); 
KX1 = KX0 * (2*pi/dx); 
KY0 = (mod(1/2 + (0:(w-1))/w, 1) - 1/2); 
KY1 = KY0 * (2*pi/dy); 
[KX,KY] = meshgrid(KX1,KY1); 
%基于向量 x 和 y 中包含的坐标返回二维网格坐标

lpf = (KX.*KX + KY.*KY < K0^2); 
%低通滤波

rec = ifft2(lpf'.*ff);
end

