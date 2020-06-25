% Test file for funScatter2Grid3D and compute derivatives
% -----------------------------------------------
% Author: Jin Yang (jyang526@wisc.edu)
% Date: 06-24-2020
%
% References
% [1] https://www.mathworks.com/matlabcentral/fileexchange/61436-regularizend
% [2] https://www.mathworks.com/matlabcentral/fileexchange/77019-augmented-lagrangian-digital-volume-correlation-aldvc
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

%% Interpolate scatterred data to regular griddata
load('testData.mat');
% p_meas: coordinates of scatterred data
% u_sim_pw_meas: measured displacements of scatterred data

% ------ u_meas ------
sxyz = [10,10,10]; % Step for griddata
smoothness = 1e-2; % Smoothness for regularization; "smoothness=0" means no regularization

[xGrid,yGrid,zGrid,u3x_meas_Grid]=funScatter2Grid3D(p_meas(:,1),p_meas(:,2),p_meas(:,3),u_sim_pw_meas(:,1),sxyz,smoothness);
[~,~,~,u3y_meas_Grid]=funScatter2Grid3D(p_meas(:,1),p_meas(:,2),p_meas(:,3),u_sim_pw_meas(:,2),sxyz,smoothness);
[~,~,~,u3z_meas_Grid]=funScatter2Grid3D(p_meas(:,1),p_meas(:,2),p_meas(:,3),u_sim_pw_meas(:,3),sxyz,smoothness);

figure, subplot(2,2,1); 
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),u3x_meas_Grid(:)); cb=colorbar; title('Displacement x');
subplot(2,2,2); 
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),u3y_meas_Grid(:)); cb=colorbar; title('Displacement y');
subplot(2,2,3); 
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),u3z_meas_Grid(:)); cb=colorbar; title('Displacement z');
subplot(2,2,4); 
u3_mag_meas_Grid = sqrt(u3x_meas_Grid.^2+u3y_meas_Grid.^2+u3z_meas_Grid.^2); title('|Disp|');
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),u3_mag_meas_Grid(:)); cb=colorbar;


%% Compute derivatives
% ----- F_meas ------
% u3_meas_Vector = [u1_pt1, u2_pt1, u3_pt1,  u1_pt2, u2_pt2, u3_pt2,  ... ]';
% F9_meas_Vector = [F11_pt1,F21_pt1,F31_pt1,F12_pt1,F22_pt1,F32_pt1,F13_pt1,F23_pt1,F33_pt1, ...
%                   F11_pt2,F21_pt2,F31_pt2,F12_pt2,F22_pt2,F32_pt2,F13_pt2,F23_pt2,F33_pt2, ...
%                   ... Other points ... ]';
u3_meas_Vector=[u3x_meas_Grid(:),u3y_meas_Grid(:),u3z_meas_Grid(:)]'; u3_meas_Vector=u3_meas_Vector(:);
D_Grid = funDerivativeOp3(size(xGrid,1),size(xGrid,2),size(xGrid,3),sxyz); % Central finite difference operator
F9_meas_Vector=D_Grid*u3_meas_Vector;

figure, subplot(3,3,1); 
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(1:9:end)); cb=colorbar; title('F11');
subplot(3,3,2); 
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(4:9:end)); cb=colorbar; title('F12');
subplot(3,3,3); 
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(7:9:end)); cb=colorbar; title('F13');
subplot(3,3,4); 
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(2:9:end)); cb=colorbar; title('F21');
subplot(3,3,5); 
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(5:9:end)); cb=colorbar; title('F22');
subplot(3,3,6); 
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(8:9:end)); cb=colorbar; title('F23');
subplot(3,3,7); 
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(3:9:end)); cb=colorbar; title('F31');
subplot(3,3,8); 
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(6:9:end)); cb=colorbar; title('F32');
subplot(3,3,9); 
scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),F9_meas_Vector(9:9:end)); cb=colorbar; title('F33');




