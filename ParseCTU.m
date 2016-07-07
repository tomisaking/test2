% ParseCTU.m %%%%%%%%%%%%%%%%%%%%%%%
% paese the CUT file

% Date: Mar/21/2016		
% Author: Vincent Yang @NTHU
%%%%%%%%%%%%%%%%%%%%%%%%
function shapePage = ParseCTU(fileStream)
	% detect shape "BOUNDARY", i.e. start & end
    bb = regexp(fileStream, '\n');
    fileStream = fileStream(bb(1) : length(fileStream)-1) ;
    %fprintf(fileStream); 
    
	startIdx = regexp(fileStream, '{');
	finishIdx = regexp(fileStream, '}');
	
    %fprintf('%d',bb(1));
    %aa = bb(1);
    
    %shapePage{i}{j} = shapePage{i}{j}(a+4:length(shapePage{i}{j})-1) ;
	% debug
	if (length(startIdx) ~= length(finishIdx))
		fprintf('parsing ERROR: length(startIdx) ~= length(finishIdx)');        
		return;
    end
	
	shapePage = cell(1, length(length(startIdx)));
      
	for i = 1 : length(startIdx)	       
        %if  fileStream(startIdx(i)-2) == 'r'
        %    shapeStream = fileStream(startIdx(i)-8 : finishIdx(i));
        %elseif fileStream(startIdx(i)-2) == 'k'
        %    shapeStream = fileStream(startIdx(i)-7 : finishIdx(i));
        %end
        
        if(i)==1
            a = 0;
        else
            a = finishIdx(i-1);
        end
        shapeStream = fileStream(a+1 : finishIdx(i));
        %fprintf(shapeStream); 
        %fprintf('\n'); 
		% remove all "white space"
		shapeStream = regexprep(shapeStream, '\s|\(|\)|\{|\}', '');
		shapePage{i} = regexp(shapeStream, ',', 'split');
        
	end
	 
end

