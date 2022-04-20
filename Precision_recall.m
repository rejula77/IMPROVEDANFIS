function [pre_hsv, pre_ycbcr, rec_hsv, rec_ycbcr, f_hsv, f_ycbcr] = Precision_recall(or_seg_g, s_img1, s_img2)

bw = im2bw(or_seg_g);

po_part = length(find(bw == 1)); % positive part
ne_part = length(find(bw == 0)); % Negative part

bw_s1 = im2bw(s_img1);
bw_s2 = im2bw(s_img2);

bw = double(bw);
bw_s1 = double(bw_s1);
bw_s2 = double(bw_s2);
pc1 = 0;
pc2 = 0;
for i = 1:250
   for j = 1:250
       if bw(i,j) == 1
           if bw_s1(i,j) == 1
               pc1 = pc1 + 1;
           end
           if bw_s2(i,j) == 1
               pc2 = pc2 + 1;
           end
       end
   end
end

tp_hsv = pc1 / po_part;
tp_ycbcr = pc2 / po_part;
fp_hsv = (po_part-pc1) / po_part;
fp_ycbcr = (po_part-pc2) / po_part;

pc1 = 0;
pc2 = 0;
for i = 1:250
   for j = 1:250
       if bw(i,j) == 0
           if bw_s1(i,j) == 0
               pc1 = pc1 + 1;
           end
           if bw_s2(i,j) == 0
               pc2 = pc2 + 1;
           end
       end
   end
end

tn_hsv = pc1 / ne_part;
tn_ycbcr = pc2 / ne_part;

fn_hsv = (ne_part-pc1) / ne_part;
fn_ycbcr = (ne_part-pc2) / ne_part;

pre_hsv = tp_hsv/(tp_hsv+fp_hsv);
pre_ycbcr = tp_ycbcr/(tp_ycbcr+fp_ycbcr);


rec_hsv = tp_hsv/(tp_hsv+fn_hsv);
rec_ycbcr = tp_ycbcr/(tp_ycbcr+fn_ycbcr);

f_hsv = 2*(rec_hsv * pre_hsv) / (rec_hsv + pre_hsv);
f_ycbcr = 2*(rec_ycbcr * pre_ycbcr) / (rec_ycbcr + pre_ycbcr);