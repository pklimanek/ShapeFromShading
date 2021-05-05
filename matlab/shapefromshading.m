A = imread('kostka.png');
A = imgaussfilt(A,1);
A = rgb2gray(A);

n = size(A,1);
n2 = size(A,2);
h = n*.4;
A = rescale(A,0,h);

figure;
imshow(A,[]);

figure;
surf(A);
colormap(gray(256));
shading interp;
axis equal;
view(110,45);
axis('off');
camlight;


B = ones(n,n2) ;

% podwojone kolumny i wiersze aby po policzeniu pochodnej zgadza³y siê rozmiary
doklejenie1 = cat(2,A, A(:,n2));
doklejenie2 = cat(1,A, A(n,:));
 
pochodnax = diff(doklejenie2,1,1);
pochodnay = diff(doklejenie1,1,2);

N0 = cat(3, -pochodnax,-pochodnay, B); 
s = sqrt(sum(N0.^2,3) );
Q = repmat( s, [1 1 3] );
N = N0 ./ Q;

figure
imshow(N0);

figure
imshow(N);

d = [0 0 1];
R = reshape(d, [1 1 3]);
W = repmat(R, [n n2 1]);

T = N .* W;
Y = sum( T,3 );
L = max(0,Y);

vmin = .3;
P = max(L,vmin);
figure
imshow(P);

d = [0 0 1];
M = reshape(d,[1 1 3]);
V = repmat(M,[n n2 1]);
Z = N .* V ;
L = sum( Z,3 );

epsilon = 1e-9;
A2 = L>1-epsilon;
figure;

imshow(A2,[]);

W = sqrt(1./L.^2-1);
W = max(W,epsilon);

figure;
imshow(min(W,3));
