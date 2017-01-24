function im = runme()
im = imread('car.png');
fg = rgb2gray(im);
fg = double(fg);
fg = fg / max(max(fg));

f = getFeatures(fg);

im = resynth(f);

end


function im = resynth(f)

im = resynth_init(f.row,f.col);
d = struct();
d.mean = featureDist('mean', im, f)
d.var = featureDist('var', im, f)
d.skew = featureDist('skew', im, f)
d.kurtosis = featureDist('kurtosis', im, f)

end


function im = resynth_init(row,col)

lr = length(row);
s = 0;
for i = 1:lr
    s = s + row(i).mean;
end
s = s/lr;
im = rand(lr,length(col)) * (1-s);
end

function d = featureDist(feature, im, f)
fnew = getFeatures(im);
rd = zeros(length(f.row),1);
cd = zeros(length(f.col),1);
for i = 1:length(f.row)
    rd(i) = f.row(i).(feature) - fnew.row(i).(feature);
end

for i = 1:length(f.col)
    cd(i) = f.col(i).(feature) - fnew.col(i).(feature);
end

d = sum(cd)+sum(rd);
end


function f = getFeatures(im)
f = struct();
f.row = struct();
f.col = struct();

for i = 1:size(im,1)
    f.row(i).mean = mean(im(i,:));
    f.row(i).var = var(im(i,:));
    f.row(i).skew = skewness(im(i,:));
    f.row(i).kurtosis = kurtosis(im(i,:));
end
for i = 1:size(im,2)
    f.col(i).mean = mean(im(:,i));
    f.col(i).var = var(im(:,i));
    f.col(i).skew = skewness(im(:,i));
    f.col(i).kurtosis = kurtosis(im(:,i));
end
end