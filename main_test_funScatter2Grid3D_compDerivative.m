% Test funScatter2Grid3D and compute derivatives

clear all; close all; clc;
%% Interpolate scatterred data to regular griddata
load('testData.mat');
% p_meas: coordinates of scatterred data
% u_sim_pw_meas: measured displacements of scatterred data

% ------ u_meas ------
[xGrid,yGrid,zGrid,u3x_meas_Grid]=funScatter2Grid3D(p_meas(:,1),p_meas(:,2),p_meas(:,3),u_sim_pw_meas(:,1),[5,5,5],1e-2);
[~,~,~,u3y_meas_Grid]=funScatter2Grid3D(p_meas(:,1),p_meas(:,2),p_meas(:,3),u_sim_pw_meas(:,2),[5,5,5],1e-2);
[~,~,~,u3z_meas_Grid]=funScatter2Grid3D(p_meas(:,1),p_meas(:,2),p_meas(:,3),u_sim_pw_meas(:,3),[5,5,5],1e-2);

figure, subplot(2,2,1); title('Displacement x');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),u3x_meas_Grid(:)); cb=colorbar;
subplot(2,2,2); title('Displacement y');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),u3y_meas_Grid(:)); cb=colorbar;
subplot(2,2,3); title('Displacement z');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),u3z_meas_Grid(:)); cb=colorbar;
subplot(2,2,4); title('|Disp|');
u3_mag_meas_Grid = sqrt(u3x_meas_Grid.^2+u3y_meas_Grid.^2+u3z_meas_Grid.^2);
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),u3_mag_meas_Grid(:)); cb=colorbar;

%% Compute derivatives
% ----- F_meas ------
% u3_meas_Vector = [u1_pt1, u2_pt1, u3_pt1,  u1_pt2, u2_pt2, u3_pt2,  ... ]';
% F9_meas_Vector = [F11_pt1,F21_pt1,F31_pt1,F12_pt1,F22_pt1,F32_pt1,F13_pt1,F23_pt1,F33_pt1, ...
%                   F11_pt2,F21_pt2,F31_pt2,F12_pt2,F22_pt2,F32_pt2,F13_pt2,F23_pt2,F33_pt2, ...
%                   ... Other points ... ]';
u3_meas_Vector=[u3x_meas_Grid(:),u3y_meas_Grid(:),u3z_meas_Grid(:)]'; u3_meas_Vector=u3_meas_Vector(:);
D_Grid = funDerivativeOp3(size(xGrid,1),size(xGrid,2),size(xGrid,3),[5,5,5]);
F9_meas_Vector=D_Grid*u3_meas_Vector;

figure, subplot(3,3,1); title('F11');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(1:9:end)); cb=colorbar;
subplot(3,3,2); title('F12');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(4:9:end)); cb=colorbar;
subplot(3,3,3); title('F13');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(7:9:end)); cb=colorbar;
subplot(3,3,4); title('F21');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(2:9:end)); cb=colorbar;
subplot(3,3,5); title('F22');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(5:9:end)); cb=colorbar;
subplot(3,3,6); title('F23');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(8:9:end)); cb=colorbar;
subplot(3,3,7); title('F31');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(3:9:end)); cb=colorbar;
subplot(3,3,8); title('F32');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(6:9:end)); cb=colorbar;
subplot(3,3,9); title('F33');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(9:9:end)); cb=colorbar;




