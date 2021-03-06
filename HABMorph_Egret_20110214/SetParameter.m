outputFolder = 'Egret';
category = outputFolder;
zipfilename = sprintf('HABMorph_%s_20110214.zip',category);

%% Load in exponential model
load 'storedExponentialModel'; % load in exponential model 事先设置好的Gabor小波

%% These are the parameters associated with data preprocessing, to adjust from category to category

resizeFactor = 1; % resize the input images
numResolution = 4; % number of resolutions to search for in detection stage
sizeTemplatex = 144; sizeTemplatey = 144; % Object template size. size...x denote height, and size...y denotes width.
templateSize = [sizeTemplatex sizeTemplatey];
partSizeX = floor(sizeTemplatex/2); % part template size
partSizeY = floor(sizeTemplatex/2); 
starting = 1; % initilize by single image learning from I{starting}
originalResolution = 4; % original resolution is the one at which the imresize factor = 1, see 11th line beneath this line 
startx = 1; endx = startx + sizeTemplatex - 1; % % bounding box                         of the first object
starty = 1; endy = starty + sizeTemplatey - 1; 

%% These are parameters associated with Morphable active basis model

% to be frequently adjusted:
numIteration = 30;  % number of iterations
partRotationRange = 2*(-2:2); % absolute part rotation (rotation of partial templates)  部分
numPartRotate = length(partRotationRange);   %mark
maxPartRelativeRotation = 2;
resolutionShiftLimit = 1;
minRotationDif = (sin(maxPartRelativeRotation*pi/numOrient)-sin(0))^2 + (cos(maxPartRelativeRotation*pi/numOrient)-cos(0))^2 + 1e-10;
rotationRange = 2*(-1:1); % whole object rotation   整体
numRotate = length(rotationRange);    %整体

% to be occationally adjusted
numElement = 50; % number of Gabors in active basis
locationPerturbFraction = .2; % part perturbation
locationShiftLimit = 3; % shift in normal direction = locationShiftLimit*subsample pixels
orientShiftLimit = 1; % shift in orientation
subsampleS2 = 3; subsampleM2 = 1;
partMarginX = floor(partSizeX*.75);
partMarginY = floor(partSizeY*.75);

% to stay fixed
epsilon = .1; % allowed correlation between selected Gabors 
subsample = 1; % subsample in computing MAX1 and SUM2 maps
Correlation = CorrFilter(allFilter, epsilon); % correlation between filters

PartLocX0 = 1:partSizeX:templateSize(1)-partSizeX+1;    %[1 1+partSizeX]
PartLocY0 = 1:partSizeY:templateSize(2)-partSizeY+1;    %[1 1+partSizeY]
partLocRange = floor(sqrt(partSizeX*partSizeY)*locationPerturbFraction);
numCandPart = length(PartLocX0) * length(PartLocY0);
PartLocX = zeros(numCandPart,1);
PartLocY = zeros(numCandPart,1);
iPart = 1;
for x = PartLocX0
    for y = PartLocY0
        PartLocX(iPart) = x;        %赋值
        PartLocY(iPart) = y;
        iPart = iPart + 1;
    end
end

imageFolder = 'positiveImage'; % folder of training images  
imageName = dir([imageFolder '/*.jpg']);
numImage = size(imageName, 1); % number of training images 

save Config

%%

%% Load in training images and initialize SUM1 maps for learning
I = cell(1, numImage);
for img = 1 : numImage
	tmpIm = imread([imageFolder '/' imageName(img).name]); 
	if size(tmpIm,3) == 3
		tmpIm = rgb2gray(tmpIm);
	end
	I{img} = imresize(single(tmpIm), resizeFactor, 'nearest');  %把图像转换成单精度，大小不变
end


