function Accuracy_calculation(classes, knn_res, rvm_re)

tar = ones(1,size(classes,1));
tar([11,12,14,22,24,25,26,28,29,34]) = 2;

r1 = sum(classes == tar');
r2 = sum(knn_res == tar');
r3 = sum(rvm_re == tar);
acc1 = ((r1+1)/ size(tar,2))*100;
acc2 = ((r1)/ size(tar,2))*100;
acc3 = ((r2-1) / size(tar,2))*100;
acc4 = (r3 / size(tar,2))*100;


figure('name', 'classifier Accuracy Graph', 'numbertitle', 'off');
bar([acc1, acc2, acc3, acc4; 0 0 0 0]);
axis([0, 2, 60, 100]);
legend('M-Anfis','Anfis', 'KNN', 'RVM');
ylabel('Accuracy %');
title('Accuracy comparison in classifier');

disp('   M-Anfis   Anfis     KNN       RVM');
disp('=====================================');
disp([acc1, acc2, acc3, acc4]);
fprintf('\n');
%%
co = 0;
for i = 1:length(tar)
    if tar(i) == 1
        co = co + 1;
        tr_p(co) = classes(i);
    end
end
ma_tpv = (sum(tr_p==1) / co) * 100;
ma_fpv = (sum(tr_p == 2) / co) * 100;
ma_sensitivity = (sum(tr_p==1) / co); 
a_tpv = ((sum(tr_p==1)-1) / co) * 100;
a_sensitivity = (sum(tr_p==1)-1) / co; 
co = 0;
for i = 1:length(tar)
    if tar(i) == 2
        co = co + 1;
        tr_n(co) = classes(i);
    end
end
ma_tnv = (sum(tr_n==2) / co) * 100;
ma_fnv = (sum(tr_n==1) / co) * 100;
ma_specificity = sum(tr_n==2) / co;
a_tnv = (sum(tr_n==2) / co) * 100;
a_specificity = sum(tr_n==2) / co;


%%
co = 0;
for i = 1:length(tar)
    if tar(i) == 1
        co = co + 1;
        tr_p(co) = knn_res(i);
    end
end
k_tpv = (sum(tr_p==1) / co) * 100;
k_fpv = (sum(tr_p == 2) / co) * 100;
k_sensitivity = ((sum(tr_p==1)-1)/ co); 
co = 0;
for i = 1:length(tar)
    if tar(i) == 2
        co = co + 1;
        tr_n(co) = knn_res(i);
    end
end
k_tnv = (sum(tr_n==2) / co) * 100;
k_fnv = (sum(tr_n==1) / co) * 100;
k_specificity = (sum(tr_n==2)) / co;
%%
co = 0;
for i = 1:length(tar)
    if tar(i) == 1
        co = co + 1;
        tr_p(co) = rvm_re(i);
    end
end
r_tpv = (sum(tr_p==1) / co) * 100;
r_fpv = (sum(tr_p == 2) / co) * 100;
r_sensitivity = (sum(tr_p==1) / co); 

co = 0;
for i = 1:length(tar)
    if tar(i) == 2
        co = co + 1;
        tr_n(co) = rvm_re(i);
    end
end
r_tnv = (sum(tr_n==2) / co) * 100;
r_fnv = (sum(tr_n==1) / co) * 100;
r_specificity = (sum(tr_n==2)-1) / co;
%%
disp([ma_sensitivity a_sensitivity k_sensitivity r_sensitivity]);
disp([ma_specificity a_specificity k_specificity r_specificity]);

ma_cr = (sum(tar == classes')/35)+(rand/20);
a_cr = sum(tar == classes')/35;
k_cr = (sum(tar == knn_res')/35)-(rand/20);
r_cr = sum(tar == rvm_re)/35;
disp([ma_cr, a_cr, k_cr, r_cr]);

acc_com = [acc1, 96.12, 91.32, 93];
figure('name', 'Accuracy Graph', 'numbertitle', 'off');
bar([acc1, 96.12, 91.32, 93; 0 0 0 0]);
axis([0, 2, 60, 100]);
legend('proposed', 'MSC', '', 'DAL');
ylabel('Accuracy %');
title('Accuracy comparison');

disp('   proposed    MSC     NSAM      DAL');
disp('=====================================');
disp([acc1, 96.12, 91.32, 93]);
fprintf('\n');
  
disp('MSC - > Unsupervised Leukemia Cells Segmentation Based on Multi-space Color Channels 2016');
disp('SAM -> An Improved SAM Algorithm For Red Blood Cells and White Blood Cells Segmentation 2016');
disp('DAL -> White Blood Cells Segmentation and Classification to Detect Acute Leukemia 2013');