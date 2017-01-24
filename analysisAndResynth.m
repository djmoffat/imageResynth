%% READ IN
f = imread('car.png');
fg = rgb2gray(f);
fg = double(fg);
fg = fg / max(max(fg));
% imshow(fg);


[counts,binLocations] = imhist(fg);

%%
% [C,~] = imcontour(fg);
%%

stem(counts,binLocations);
%%
% stats = regionprops(fg, 'Centroid');
% centroids = cat(1, stats.Centroid);
% 
% hold on
% plot(centroids(:,1),centroids(:,2), 'b*')
% hold off

%%
