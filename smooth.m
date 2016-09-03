clear all;
close all;
clc;

x_offset = [1,2,3,4,5,6];
y_offset = [2,3,4,6,5,4];
y_diff_offset = [1,1];

n = length(x_offset);

spline_coeff = zeros(n+2,1);
smooth_coeff = zeros(n+2,1);

spline_matrix = zeros(n+2,n+2); %Spline matrix ,that is the H in the word 

power = [0,1,2,3];
x_matirx = zeros(n,4);
for i = 1:n
	for j = 1:4
		x_matirx(i,j) = x_offset(i)^power(j);
	end
end
spline_matrix(1:n,1:4) = x_matirx;
for i = 3:n
	for j = 5:i+2
		spline_matrix(i,j)= (x_offset(i)-x_offset(j-3))^3;
	end
end
spline_matrix(n+1,2)=1;
spline_matrix(n+1,3)=2*x_offset(1);
spline_matrix(n+1,4)=3*x_offset(1)^2;  %This is the matrix for the derivative at start point

spline_matrix(n+2,2)=1;  %This is the matrix for the derivative at the end point
spline_matrix(n+2,3)=2*x_offset(n);
spline_matrix(n+2,4)=3*x_offset(n)^2; 
for i = 5:n+2
	spline_matrix(n+2,i)=3*(x_offset(n)-x_offset(i-3))^2;
end

spline_right = zeros(n+2,1);
spline_right(1:n,1) = y_offset';
spline_right(n+1,1) = y_diff_offset(1);
spline_right(n+2,1) = y_diff_offset(2);


smooth_matrix  = zeros(2*n,n+2); %smooth matrix ,that is HL in the word
smooth_matrix(1:n+2,1:n+2) = spline_matrix;
shear_force = eye(n-2,n-2);
smooth_matrix(n+3:2*n,5:n+2)=shear_force;

smooth_right=zeros(2*n,1);
smooth_right(1:n+2,1)=spline_right;

weight_dis = eye(n,n); %The weight of the displacement at each point
weight_diff = eye(2,2); %The weight of the derivative at the start and end point
weight_force = eye(n-2,n-2); %The weight of the shear force at each connection point

weight = eye(2*n,2*n); %initialize the weight matrix;
weight(1:n,1:n) = weight_dis;
weight(n+1:n+2,n+1:n+2) = weight_diff;
weight(n+3:2*n,n+3:2*n) = weight_force;

smooth_coeff = inv(smooth_matrix'*weight*smooth_matrix)*smooth_matrix'*weight*smooth_right; 
%Obtain the coeffcient of curve after smooth.
spline_coeff = inv(spline_matrix)*spline_right;



plot(x_offset,y_offset,'o');  %Plot the original offset point

x_plot = linspace(x_offset(1),x_offset(n),1000);
N = length(x_plot);
x_plot_matrix = zeros(n+2,N);
x_plot_matrix(1,:)=x_plot.^0;
x_plot_matrix(2,:)=x_plot;
x_plot_matrix(3,:)=x_plot.^2;
x_plot_matrix(4,:)=x_plot.^3;
for i = 5:n+2
	for j= 1:N
		if(x_plot(j)>x_offset(i-3))
			x_plot_matrix(i,j)=(x_plot(j)-x_offset(i-3))^3;
		end
	end
end

y_plot = spline_coeff'*x_plot_matrix;   %This is the curve of spline interpolation curve 
y_plot_smooth = smooth_coeff'*x_plot_matrix;   %This is the curve of spline interpolation curve after smooth
hold on;
plot(x_plot,y_plot);
hold on;
plot(x_plot,y_plot_smooth);


x_plot_curve = zeros(n+2,N);
x_plot_curve(1,:)=0;
x_plot_curve(2,:)=0;
x_plot_curve(3,:)=2*x_plot.^0;
x_plot_curve(4,:)=6*x_plot;
for i = 5:n+2
	for j= 1:N
		if(x_plot(j)>x_offset(i-3))
			x_plot_curve(i,j) = 6*(x_plot(j)-x_offset(i-3));
		end
	end
end
y_curve = smooth_coeff'*x_plot_curve;  %Calculate the curvature value at each x value to plot the curvature value in axes 2
hold on;
plot(x_plot,y_curve);
xlabel('X','FontWeight','bold');
ylabel('Curvature \rho','FontWeight','bold');

x_curvature = zeros(n+2,n);
x_curvature(1,:)=0;
x_curvature(2,:)=0;
x_curvature(3,:)=2*x_offset.^0;
x_curvature(4,:)=6*x_offset;
for i = 5:n+2
    for j= 1:n
        if(x_offset(j)>x_offset(i-3))
            x_curvature(i,j) = 6*(x_offset(j)-x_offset(i-3));
        end
    end
end
y_curve_judge = smooth_coeff'*x_curvature; %calculate the curvature at each offset point

flag = true; %This is the flag to show whether the curve is smooth or not 
for i = 2:n-1
    if (y_curve_judge(i-1)*y_curve_judge(i)<0 && y_curve_judge(i+1)*y_curve_judge(i)<0)
        flag = false;
    end
end