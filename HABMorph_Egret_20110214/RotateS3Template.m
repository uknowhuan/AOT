
denseX = -floor(sizeTemplatex/2) + (1:sizeTemplatex);
denseY = -floor(sizeTemplatey/2) + (1:sizeTemplatey);
count = 0;
inRow = zeros(length(denseX)*length(denseY),1,'single');
inCol = zeros(length(denseX)*length(denseY),1,'single');
for y = denseY
    for x = denseX
        count = count+1;
        inRow(count) = x;
        inCol(count) = y;
    end
end

%minx = min(S3SelectedRow(:)); maxx = max(S3SelectedRow(:)); centerx = floor((minx+maxx)/2.); 
%miny = min(S3SelectedCol(:)); maxy = max(S3SelectedCol(:)); centery = floor((miny+maxy)/2.);

centerx = floor(sizeTemplatex/2);
centery = floor(sizeTemplatey/2);

for i = 1 : numCandPart
	S3SelectedRow(i) = S3SelectedRow(i) - centerx;
	S3SelectedCol(i) = S3SelectedCol(i) - centery;
end
for r = 1:length(rotationRange)
	rot = rotationRange(r);
    
    tScale = 0; rScale = 1; cScale = 1;
    inS = zeros(numel(inRow),1,'single');
    [allS3SelectedRow(r,:) allS3SelectedCol(r,:) tmpO]...
        = mexc_TemplateAffineTransform(tScale,rScale,cScale,rot,...
        single(S3SelectedRow),...
        single(S3SelectedCol),single(S3SelectedOri),inS,numOrient);
    allS3SelectedOri(r,:) = tmpO;
    
end

