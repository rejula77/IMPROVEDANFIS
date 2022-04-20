function classes = Anfis_test(te_fea)

load out_fis out_fis
classes = [];
for i = 1:size(te_fea,1)
    di = [];
    for j = 1:size(out_fis,1)
        va = pdist2(te_fea(i,:), out_fis(j,1:end-1),'euclidean');
        di = [di, va];
    end
    [va, po] = sort(di);
    classes = [classes; out_fis(po(1), end)];
end
classes = round(classes);