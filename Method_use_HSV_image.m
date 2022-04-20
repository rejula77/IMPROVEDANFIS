function [seg_img, ba_img2] = Method_use_HSV_image(in_img)

% ===== Segmentation =====
g_img = rgb2gray(in_img); % Gray Scale Image

% ===== Contrast Stretching =====
rtemp = min(g_img);         
rmin = min(rtemp);      
rtemp = max(g_img);         
rmax = max(rtemp);      
m = 255/(rmax - rmin);  
c = 255 - m*rmax;       
cs_img = m*g_img + c;  % Contrast Stretching      
figure('name','Contrast Stretching','numbertitle','off');
subplot(1,2,1); imshow(g_img);title('Gray Scale Image');
subplot(1,2,2); imshow(cs_img),title('Contrast Stretching');

ba_img = zeros(size(cs_img,1), size(cs_img,2));
for i = 1:size(cs_img,1)
    for j = 1:size(cs_img,2)
        if cs_img(i,j) > 200 % Threshold 1
            ba_img(i,j) = 255;
        end
    end
end
figure('name','Background','numbertitle','off'); imshow(ba_img);

[h_img S V]=rgb2hsv(in_img);
ba_img2 = zeros(size(h_img,1), size(h_img,2));
for i = 1:size(h_img,1)
    for j = 1:size(h_img,2)
        if h_img(i,j) > 0.3 % Threshold 2
            ba_img2(i,j) = 255;
        end
    end
end
figure('name','Background','numbertitle','off'); imshow(ba_img2);


int_img = g_img; % intersection Image
for i = 1:size(int_img,1)
    for j = 1:size(int_img,2)
        if ba_img(i,j) == 255
            int_img(i,j) = 0;
        end
        if ba_img2(i,j) == 0
            int_img(i,j) = 0;
        end
    end
end
figure('name','intersection Image','numbertitle','off');
imshow(int_img); title('intersection Image');

bi_img = zeros(size(int_img,1), size(int_img,2)); % Binary Image
for i = 1:size(int_img,1)
    for j = 1:size(int_img,2)
        if int_img(i,j) ~= 0
            bi_img(i,j,1) = 1;
        end
    end
end
figure('name','Binary Image','numbertitle','off');
imshow(bi_img); title('Binary Image');

% Morphological Operation
se = strel('disk',10);
clo_img = imclose(bi_img,se); % closing operation
op_img = imopen(clo_img,se);  % Opening operation
figure('name','Morphological Operation','numbertitle','off');
subplot(1,2,1); imshow(clo_img); title('Closing Operation');
subplot(1,2,2); imshow(op_img); title('Opening Operation');

mcr_img = medfilt2(op_img, [7 7]); % median filtering 
figure('name','Maximum connected region extraction','numbertitle','off');
imshow(mcr_img); title('MCR Image');

seg_img = zeros(size(in_img,1), size(in_img,2), size(in_img,3))+255; % RGB color image

for i = 1:size(int_img,1)
    for j = 1:size(int_img,2)
        if mcr_img(i,j) ~= 0
            seg_img(i,j,1) = in_img(i,j,1);
            seg_img(i,j,2) = in_img(i,j,2);
            seg_img(i,j,3) = in_img(i,j,3);
        end
    end
end
figure('name','Segmentation Image','numbertitle','off'); 
imshow(uint8(seg_img)); title('Segmentation Image');