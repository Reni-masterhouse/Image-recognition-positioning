%读取图像
Img1 = imread('assets/photo.png');
Img2 = imread('assets/rotation.tif');

%将转换后的灰度图中的单精度变量存储为single数据类型的4字节浮点值
Img1_g = single(rgb2gray(Img1));
Img2_g = single(rgb2gray(Img2));

%对图像低通滤波去噪，给定参数为0.7
Img1_g = denoise(Img1_g, 0.7);
Img2_g = denoise(Img2_g, 0.7);

%使用vl_sift算法
[f1, d1] = vl_sift(Img1_g);
[f2, d2] = vl_sift(Img2_g);

%对Img1_g和Img2_g两图像进行程度为2的匹配
[matches, ~] = vl_ubcmatch(d1, d2, 2);

%找到匹配点的位置
pos1 = f1(1:2, matches(1, :));
pos2 = f2(1:2, matches(2, :));

%使用estimateGeometricTransform函数基于ransac方法进行仿射变换
[trans, ~, ~] = estimateGeometricTransform(pos1', pos2', 'affine');

%给出图1大小和具体四个角的坐标值
[h, w, ~] = size(Img1);
cx = [1 w w 1];
cy = [1 1 h h];

%给出图2对应四个角的点的坐标值
[u, v] = transformPointsForward(trans, cx, cy);

%生成图1
subplot(1,2,1);
imshow(uint8(Img1));
hold on;

%用蓝色*标记图1的匹配点
plot(f1(1,matches(1,:)),f1(2,matches(1,:)),'b*');

%生成图2
subplot(1,2,2);
imshow(uint8(Img2));
hold on;

%用红色*标记图1的匹配点
plot(f2(1,matches(2,:)),f2(2,matches(2,:)),'r*'); 

%使用垂直串联数组链接四个点生成多边形
poly = drawpolygon('Position', vertcat(u, v)');

%输出坐标值
disp(vertcat(u, v)')



