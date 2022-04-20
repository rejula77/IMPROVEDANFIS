function lab_me = rgb_lab_imagedb(in_img)

% RGB to LAB Image Convertion
% in_img -> Input RGB Image
% lab-me -> LAB Median filter image

cform = makecform('srgb2lab');
lab = applycform(in_img, cform);

for i = 1:size(in_img,3) % Median Filter
    lab_me(:,:,i) = medfilt2(lab(:,:,i), [7 7]);
end
% 
% figure('name','Lab Image','numbertitle','off');
% subplot(1,2,1); imshow(lab); title('LAB Image');
% 
% subplot(1,2,2); imshow(lab_me); title('LAB median filter Image');
