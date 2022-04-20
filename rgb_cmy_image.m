function cmy_me = rgb_cmy_image(in_img)
% RGB to CMY Image Convertion
% in_img -> Input RGB Image
% cmy-me -> CMY Median filter image

f = im2double(in_img);
r=f(:,:,1);
g=f(:,:,2);
b=f(:,:,3);
c = 1-r;
m = 1-g;
y = 1-b;
CMY = cat(3,c,m,y);

for i = 1:size(in_img,3) % Median Filter
    cmy_me(:,:,i) = medfilt2(CMY(:,:,i), [7 7]);
end

figure('name','Lab Image','numbertitle','off');
subplot(1,2,1); imshow(CMY); title('CMY Image');

subplot(1,2,2); imshow(cmy_me); title('CMY Median filter Image');
