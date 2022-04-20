clc
clear all
close all
warning off

mscc = 96.12; % Multi-space Color Channels
Amin = 95.80;
Vincent = 94.97;
Proposed = 97.1429; 



figure;
bar([Proposed, 0; mscc, 0; Vincent,0; Amin, 0].');
legend('M-Anfis','MSCC','Vincent', 'Amin');
axis([0,2, 60, 100]);
title('Accuracy'); 

accuracy = [97.1429   94.2857   91.4286   82.8571];
sensitivity = [0.9600    0.9200    0.8800    0.8000];
specificity = [0.9000    0.9000    0.9000    0.8000];
clasification = [0.9567    0.9429    0.9105    0.8286];

figure; 
bar([accuracy/100;[0 0 0 0]])
legend('M-Anfis','Anfis', 'KNN', 'RVM');
ylabel('Accuracy %');
title('Accuracy Value');
axis([0, 2, 0, 1]);

figure; 
bar([sensitivity;[0 0 0 0]])
legend('M-Anfis','Anfis', 'KNN', 'RVM');
ylabel('sensitivity');
title('sensitivity Value');
axis([0, 2, 0, 1]);

figure; 
bar([specificity;[0 0 0 0]])
legend('M-Anfis','Anfis', 'KNN', 'RVM');
ylabel('specificity');
title('specificity Value');
axis([0, 2, 0, 1]);

figure; 
bar([clasification;[0 0 0 0]])
legend('M-Anfis','Anfis', 'KNN', 'RVM');
ylabel('classification');
title('classification Value');
axis([0, 2, 0, 1]);

figure;
bar([accuracy/100; sensitivity; specificity; clasification].');
legend('Accuracy','sensitivity','specificity','classification');
xlabel('M-Anfis   Anfis   KNN    RVM');

%% Segmentation 
mdt = [96.3456 97.2896 89.3216 92.5936 89.7856 94.8224];
dt = [95.7264 88.0432 79.848 70.9344 70.0864 67.3392];
figure;
bar([mdt; dt].');
title('Segmentation Accuracy');
ylabel('Accuracy [%]');
legend('MDTS', 'DTS');
xlabel('Cell Types');

figure;
hold on
plot(mdt, '-sk','linewidth',2);
plot(dt, '->r','linewidth', 2);
grid on
title('Segmentation Accuracy');
ylabel('Accuracy [%]');
legend('MDTS', 'DTS');
xlabel('cell Types');

prf = [0.963456 0.9029	0.9999	0.9489
0.972896 0.9855	0.9945	0.9900
0.893216 0.8833	0.9909	0.9340
0.925936 0.8640	0.9985	0.9264
0.897856 0.8760	0.9996	0.9337
0.948224 0.9986	0.9990	0.9988];
figure;
bar(prf);
legend('Accuracy','Precision','Recall','F-measure');
xlabel('Cell Types');
axis([0, 7, .5, 1.1]);
title('Modified Dual Threshold');

acc = [0.972896 0.957264 0.9613; 0 0 0];
figure;
bar(acc);
legend('MDTS','DTS','CNC');
ylabel('Accuracy');
axis([0, 2, 0, 1]);

val = [0.76	0.72 0.7395; 0.60 0.85 0.7034; 
    0.59 0.76 0.6643; 0.6 0.85 0.7034;
    0.98 0.95 0.9648; 0.984	0.96 0.9719];
figure; 
bar(val);
legend('Precision','Recall','F-measure');
xlabel('1>MRLS 2>GAC 3>RF 4>NMCMP 5>GC 6>IDT')

val = [0.76 0.60 0.59 0.6 0.98 0.984];
figure; 
bar(val);
title('Precision');
xlabel('1>MRLS 2>GAC 3>RF 4>NMCMP 5>GC 6>IDT');

val = [0.72 0.85 0.76 0.85 0.95 0.96];
figure; 
bar(val);
title('Recall');
xlabel('1>MRLS 2>GAC 3>RF 4>NMCMP 5>GC 6>IDT');

val = [0.7395; 0.7034; 0.6643; 0.7034; 0.9648; 0.9719];
figure; 
bar(val);
title('F-measure');
xlabel('1>MRLS 2>GAC 3>RF 4>NMCMP 5>GC 6>IDT');
% Multireference Level Set
% Geodesic Active Contour
% Random Forest
% Nuclear Morphology and cytoplasmic multidimensional profiling
% Graph cut
% Improve Dual threshold



