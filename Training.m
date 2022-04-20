function Training
clc
clear all
close all
warning off

listing = dir('DB_img');
tr_fea = [];
h = waitbar(0,'Please wait...');
for no = 3:length(listing)-5
    waitbar(no / length(listing));
    % ===== Read Input Image =====
    im_name = listing(no).name;
    in_img = imread(['DB_img\', im_name]);
    in_img = imresize(in_img, [250, 250]);

    % ===== Pre-Processing =====
    lab_me = rgb_lab_imagedb(in_img); 
    cmy_me = rgb_cmy_imagedb(in_img);

    img = double(lab_me) -  cmy_me;

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

    ba_img = zeros(size(cs_img,1), size(cs_img,2));
    for i = 1:size(cs_img,1)
        for j = 1:size(cs_img,2)
            if cs_img(i,j) > 200 % Threshold 1
                ba_img(i,j) = 255;
            end
        end
    end

    [h_img S V]=rgb2hsv(in_img);

    ba_img2 = zeros(size(h_img,1), size(h_img,2));
    for i = 1:size(h_img,1)
        for j = 1:size(h_img,2)
            if h_img(i,j) > 0.3 % Threshold 2
                ba_img2(i,j) = 255;
            end
        end
    end

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

    bi_img = zeros(size(int_img,1), size(int_img,2)); % Binary Image
    for i = 1:size(int_img,1)
        for j = 1:size(int_img,2)
            if int_img(i,j) ~= 0
                bi_img(i,j,1) = 1;
            end
        end
    end
    
    % Morphological Operation
    se = strel('disk',10);
    clo_img = imclose(bi_img,se); % closing operation
    op_img = imopen(clo_img,se);  % Opening operation

    mcr_img = medfilt2(op_img, [7 7]); % median filtering 

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

    % ===== Feature Extraction ===== 
    im = rgb2gray(uint8(seg_img));
    stats = regionprops(im,'all'); % regionprops
    r = mean(mean(seg_img(:,:,1)));
    g = mean(mean(seg_img(:,:,2)));
    b = mean(mean(seg_img(:,:,3)));
    ax_le = []; 
    for i = 1:length(stats)
        ax_le = [ax_le; stats(i).MajorAxisLength];
    end
    [va, po] = sort(ax_le, 'descend');
    fea = [stats(po(2)).Area, stats(po(2)).Eccentricity, r, g, b];
    tr_fea = [tr_fea; fea];
    close all
    clear stats;
end
close(h);
tr_fea;
tar = ones(1,size(tr_fea,1));
tar([11,12,14,22,24,25,26,28,29]) = 2;

% ===== Anfis =====
trnData = [tr_fea, tar.']; 
mfType = 'gbellmf';
numMFs = 5;
in_fis = genfis1(trnData,numMFs,mfType); 
out_fis = trnData;
save in_fis in_fis
save out_fis out_fis
% ===== KNN =====
knn_tr = [tr_fea, tar.'];
save knn_tr knn_tr

% ===== RVM ==== Relevance Vector Machine
RVM_fea = [];
for i = 1:size(tr_fea,1)
    temp = tr_fea(i,:);
    f_v = [];
    for j = 1:size(temp,2);
        w = 1 / (1 - exp(temp(j)));
        f_v = [f_v, w];
    end
    f_v = [f_v, tar(i)];
    RVM_fea = [RVM_fea; f_v];
end
save RVM_fea RVM_fea

msgbox('Database trained successfully', 'message');
 
     


