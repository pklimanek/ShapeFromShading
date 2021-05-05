I1=imread('real1.png');
I2=imread('real2.png');
I3=imread('real3.png');
I4=imread('real4.png');
for i = 1:size(I1,1)
for j = 1:size(I1,2)
images(i,j,1) = I1(i,j);
end
end

% Initializations
albedo=zeros(size(I1,1),size(I1,2));
p = zeros(size(I1,1),size(I1,2));
q = zeros(size(I1,1),size(I1,2));
for i = 1:size(I1,1)
for j = 1:size(I1,1)
normal_vector(i,j,1) = 0;
normal_vector(i,j,2) = 0;
normal_vector(i,j,3) = 0;
end
end
L=[0,0,1;0.2,0,1;-0.2,0,1;0,0.2,1]; %position of light source
normal=[0;0;0];

% processing
for i = 1:size(I1,1)
for j = 1:size(I1,2)
for im = 1:4
I(im) = double(images(i,j,im));
end
A = L'*L;
b = L'*I';
g = inv(A)*b;
albedo(i,j) = norm(g);
normal = g/albedo(i,j);
normal_vector(i,j,1) = normal(1);

normal_vector(i,j,2) = normal(2);
normal_vector(i,j,3) = normal(3);
p(i,j) = normal(1)/normal(3);
q(i,j) = normal(2)/normal(3);
end
end
%compute albedo
maxalbedo = max(max(albedo) );
if( maxalbedo > 0)
albedo = albedo/maxalbedo;
end
%compute depth
depth=zeros(size(I1,1));
for i = 2:size(I1,1)
for j = 2:size(I1,1)
depth(i,j) = depth(i-1,j-1)+q(i,j)+p(i,j);
end
end
%display estimated surface
figure(15);
surfl(depth);
colormap(gray);
grid off;
shading interp