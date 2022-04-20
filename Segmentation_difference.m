function Segmentation_difference

clc
clear all
close all

% ===== Read Input Image =====
name = 'seg_img\Neutrophil cells seg.jpg';
in_img = imread('seg_img\Neutrophil cells.jpg');
figure('name','Input Image');
imshow(in_img); title('Input Image');
in_img = imresize(in_img, [250, 250]);

% ===== Pre-Processing =====
lab_me = rgb_lab_image(in_img);  % LAB Image
cmy_me = rgb_cmy_image(in_img);  % CMY Image 

img = double(lab_me) -  cmy_me;

[hsv_seg_img, s_img1] = Method_use_HSV_image(in_img);
[ycbcr_seg_img, s_img2] = Method_use_YCbCr_image(in_img);
close all

figure('name','Input Image');
imshow(uint8(in_img));

figure;
subplot(1,2,1); imshow(s_img1); title('HSV using segmentation');
subplot(1,2,2); imshow(s_img2); title('YCbCr using segmentation');

figure;
subplot(1,2,1); imshow(uint8(hsv_seg_img)); title('HSV using segmentation');
subplot(1,2,2); imshow(uint8(ycbcr_seg_img)); title('YCbCr using segmentation');

or_seg = imread(name);
or_seg = imresize(or_seg, [250, 250]);
or_seg_g = rgb2gray(or_seg);

[pre_hsv, pre_ycbcr, rec_hsv, rec_ycbcr, f_hsv, f_ycbcr] = Precision_recall(or_seg_g, s_img1, s_img2);
disp('Precision   Recall  F-measure');
disp('=================================');
disp([pre_hsv rec_hsv f_hsv]);
disp([pre_ycbcr, rec_ycbcr, f_ycbcr]);

diff1 = (or_seg_g == s_img1);
diff2 = (or_seg_g == s_img2);

[h, w, l]= size(in_img);
to_pix = h*w;
h_to = sum(sum(diff1));
y_to = sum(sum(diff2));
hsv_acc = (h_to / to_pix) * 100;
ycbcr_acc = (y_to / to_pix) * 100;

disp(['HSV Using segmentation Accuracy = ', num2str(hsv_acc)]);
disp(['YCbCr Using segmentation Accuracy = ', num2str(ycbcr_acc)]);

% ===== Feature Extraction ===== 
seg_img = ycbcr_seg_img;
r = mean(mean(seg_img(:,:,1))); % Red color 
g = mean(mean(seg_img(:,:,2))); % green color
b = mean(mean(seg_img(:,:,3))); % Blue color

fea = regionprops(seg_img, 'Area','Solidity','Eccentricity','ConvexArea','Perimeter');

feat = [fea(1).Area, fea(1).Solidity, fea(1).ConvexArea, fea(1).Eccentricity, fea(1).Perimeter, r, g, b];
