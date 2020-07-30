# Scatter2Grid3D
Matlab code: Interpolate 3D scatterred data to gridded data and compute their gradients

# funDerivativeOp3
Matlab code: Generate a central finite difference operator to compute gradients

## ****** ATTENTION ******  
% The "x,y,z" or "1-,2-,3-" coordinates in this exchange file correspond to  
% the 1st, 2nd and 3rd indices of Matlab workspace variable. For example,  
% p_meas(:,1) and p_meas(:,2) are the x- & y-coordinates of scattered points.  
 
% This is a little different from some MATLAB image processing functions. 

% For example, if a 3D image has size MxNxL, in this code, we always have  
% the image size_x=M, size_y=N, size_z=L. If you use some Matlab computer  
% vision/image post-processing function, for example, 'imagesc3D', or   
% 'imagesc', or 'imshow', or 'surf', it will reads size_x=N, size_y=M, size_z=L. 
 
% Please pay attention to this.  
  
# Contact and Support
Jin Yang, Postdoc at University of Wisconsin-Madison, Email: jyang526@wisc.edu
