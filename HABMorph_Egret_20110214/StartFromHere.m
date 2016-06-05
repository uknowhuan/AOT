%
% LEARNING HIERARCHICAL ACTIVE BASIS MODEL FROM NONALIGNED IMAGES
%


clear
if (exist('output','dir'))
    delete('output/*.*'); 
else
    mkdir('output');
end

if ~exist('working','dir')
    mkdir('working');
end

SetParameter;
Compile;

SUM1MAX1; %¿ªÊ¼¼ÆËã

InitializeTemplate; 
EMLearning; 
GenerateHtml;
