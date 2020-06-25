function [xGrid,yGrid,zGrid,fGrid] = funScatter2Grid3D(varargin)
%FUNSCATTER2GRID3D: Interpolate 3D scattered data to gridded data.
%   [xGrid,yGrid,zGrid,fGrid] = funScatter2Grid3D(x,y,z,f,sxyz,smoothness)
%   
%   INPUT: 3D scatterred data with coordinates x,y,z and value f
%          sxyz = [sx,sy,sz] is the step for griddata
%          smoothness is the coefficient for regularization (function regularizeNd[1])
%
%   OUTPUT: 3D gridded data (fGrid) 
%           Gridded coordinates (xGrid,yGrid,zGrid)
%
% -----------------------------------------------
% Author: Jin Yang (jyang526@wisc.edu)
% Date: 06-24-2020
%
% Reference
% [1] https://www.mathworks.com/matlabcentral/fileexchange/61436-regularizend
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[x y z f sxyz smoothness] = parseargs(varargin);
x=x(:); y=y(:); z=z(:); smoothness=abs(smoothness);

if isempty(smoothness)
    alpha = 0; % No regularization
end
if isempty(sxyz)
    sxyz = floor((max([x,y,z])-min([x,y,z]))/20);
end
    
xList = min(x(:)):sxyz(1):max(x(:)+sxyz(1));
yList = min(y(:)):sxyz(2):max(y(:)+sxyz(2));
zList = min(z(:)):sxyz(3):max(z(:)+sxyz(3));
[xGrid,yGrid,zGrid] = meshgrid(xList,yList,zList);
 

% ------ Regularization ------
if smoothness==0
    f_interp = scatteredInterpolant(x,y,z,f,'linear');
    fGrid = reshape(f_interp(xGrid(:),yGrid(:),zGrid(:)), size(xGrid));
else
    fGrid = regularizeNd([y,x,z],f,{yList,xList,zList},smoothness);
end

% ------ Plot and check ------
% figure, scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),fGrid(:)); cb=colorbar;
% figure, scatter3(xGrid(:),yGrid(:),zGrid(:),ones(length(xGrid(:)),1),fGrid2(:)); cb=colorbar;
% figure, scatter3(x,y,z,ones(length(x(:)),1),f(:)); cb=colorbar;


end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function [x y z f sxyz smoothness] = parseargs(vargin)
x=[]; y=[]; z=[]; f=[]; sxyz=[]; smoothness=[];
x=vargin{1}; y=vargin{2}; z=vargin{3}; f=vargin{4};
try 
    sxyz=vargin{5};
    try
        smoothness=vargin{6};
    catch
    end
catch
end

end