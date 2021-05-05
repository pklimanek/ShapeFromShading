A = imread('kubek_sqr.jpg');
A = rgb2gray(A);

n = size(A,1);
n2 = size(A,2);
z = n*n2;

wektX = (1:1:n)';

w = wektX;
for i = 1:n-1
    wektX = [wektX w];
end

wektX = wektX(:);
wektY = sort(wektX);

transposeA = A';
wektZ = transposeA(:);

figure
plot3(wektX,wektY,wektZ)
%figure
%plot3(wektX,wektY,wektZ,'.')
figure
scatter3(wektX,wektY,wektZ)

xyzPoints = [wektX wektY wektZ];
xyzPoints = single(xyzPoints);

ptCloud = pointCloud(xyzPoints);
figure
pcshow(ptCloud)