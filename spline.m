clear all;
close all;
clc;

x_offset = [1,2,3,4,5,6];
y_offset = [2,5,1,5,3,3];
y_diff_offset = [1,1];

n = length(x_offset);

spline_coeff = zeros(n+2,1);
spline_matrix = zeros(n+2,n+2); %The matrix that is used for calculate the spline coefficient, H in the word

power = [0,1,2,3];
x_matirx = zeros(n,4);
for i = 1:n %Generating part of the matrix H
	for j = 1:4
		x_matirx(i,j) = x_offset(i)^power(j);
	end
end
spline_matrix(1:n,1:4) = x_matirx;
for i = 3:n %Generating the matrix H
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
for i = 5:n+2 %Generating part of the matrix H
	spline_matrix(n+2,i)=3*(x_offset(n)-x_offset(i-3))^2;
end

spline_right = zeros(n+2,1);   %right hand for spline interpolation 
spline_right(1:n,1) = y_offset';
spline_right(n+1,1) = y_diff_offset(1);
spline_right(n+2,1) = y_diff_offset(2);

spline_coeff = inv(spline_matrix)*spline_right; %The coefficient of spline curve 
plot(x_offset,y_offset,'o');

x_plot = linspace(x_offset(1),x_offset(n),1000); 
N = length(x_plot);
x_plot_matrix = zeros(n+2,N);
x_plot_matrix(1,:)=x_plot.^0;
x_plot_matrix(2,:)=x_plot;
x_plot_matrix(3,:)=x_plot.^2;
x_plot_matrix(4,:)=x_plot.^3;
for i = 5:n+2 %Generate the matrix used for the plot 
	for j= 1:N
		if(x_plot(j)>x_offset(i-3))
			x_plot_matrix(i,j)=(x_plot(j)-x_offset(i-3))^3;
		end
	end
end

y_plot = spline_coeff'*x_plot_matrix;
hold on;
plot(x_plot,y_plot);

x_plot_curve = zeros(n+2,N); %This is the curvature of this spline curve
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
y_curve = spline_coeff'*x_plot_curve;
hold on;
plot(x_plot,y_curve);