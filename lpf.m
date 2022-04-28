%读取图像
Img1 = imread('assets/photo.png');
Img2 = imread('assets/rotation_noise.tif');

%将转换后的灰度图中的单精度变量存储为single数据类型的4字节浮点值
Img1_g = single(rgb2gray(Img1));
Img2_g = single(rgb2gray(Img2));

%对图像低通滤波去噪，给定参数为0.7
Img1_g = denoise(Img1_g, 0.7);
Img2_g = denoise(Img2_g, 0.7);

%输出滤波后图像
subplot(1,2,1);
imshow(Img1_g, []);
subplot(1,2,2);
imshow(Img2_g, []);