denseX = -floor(partSizeX/2) + (1:partSizeX);
denseY = -floor(partSizeY/2) + (1:partSizeY);
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

% non-overlapping partial templates
for iPart = 1:numCandPart
	centerx = floor(partSizeX/2);
    centery = floor(partSizeY/2);
    selectedx{iPart} = selectedx{iPart}-centerx;
    selectedy{iPart} = selectedy{iPart}-centery;
	for r = 1:length(partRotationRange)
		rot = partRotationRange(r);
        tScale = 0; rScale = 1; cScale = 1;
        inS = zeros(numel(inRow),1,'single');
        [allSelectedx{iPart,r} allSelectedy{iPart,r} tmpO]...
            = mexc_TemplateAffineTransform(tScale,rScale,cScale,rot,...
            single(selectedx{iPart}),...
            single(selectedy{iPart}),single(selectedOrient{iPart}),inS,numOrient);
        tmpO(tmpO<0) = tmpO(tmpO<0) + numOrient;
        tmpO(tmpO>=numOrient) = tmpO(tmpO>=numOrient) - numOrient;
        allSelectedOrient{iPart,r} = tmpO;
	end
end

% overlapping partial templates
for iPart = 1:numCandPart
	centerx = floor(partSizeX/2 + partMarginX);
    centery = floor(partSizeY/2 + partMarginY);
    largerSelectedx{iPart} = largerSelectedx{iPart}-centerx;
    largerSelectedy{iPart} = largerSelectedy{iPart}-centery;
	for r = 1:length(partRotationRange)
		rot = partRotationRange(r);
        tScale = 0; rScale = 1; cScale = 1;
        inS = zeros(numel(inRow),1,'single');
        [largerAllSelectedx{iPart,r} largerAllSelectedy{iPart,r} tmpO]...
            = mexc_TemplateAffineTransform(tScale,rScale,cScale,rot,...
            single(largerSelectedx{iPart}),...
            single(largerSelectedy{iPart}),single(largerSelectedOrient{iPart}),inS,numOrient);
        tmpO(tmpO<0) = tmpO(tmpO<0) + numOrient;
        tmpO(tmpO>=numOrient) = tmpO(tmpO>=numOrient) - numOrient;
        largerAllSelectedOrient{iPart,r} = tmpO;
	end
end



