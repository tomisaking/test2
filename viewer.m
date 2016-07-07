% CtuViewer.m 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project: ITRI LDI
% Application: for "Contour Output" debugging
% 
% Date: Mar/18/2016
% Author: Vincent Yang @NTHU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function CtuViewer(fileName, enMappingTOOLBOX, moveStep)
function [] = viewer(arg1)
	tic
	clc	% ?
	%clear;	% ?
	clearvars -global -except arg1	% ?
	close all	% ?
	format long g

	hold on
	axis equal
	grid

	arcStep = round(2*pi / 32, 4);
	enMappingTOOLBOX = 0;
	moveStep = 0;
	% fileName = 'FBGA256_test';
	% fileName = 'PCB_CopperL1';
	fileName = arg1;
	%fileExten = '.ctu2';
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	SPACING = 1000000;

	fileStream = fileread([fileName]);
	shapePage = ParseCTU(fileStream);
	
	for i = 1 : length(shapePage)	% every shape	
		x = 0;
		y = 0;
		for j = 1 : length(shapePage{i})
			if isempty(shapePage{i}{j})
				continue;
			elseif j == 1
                %fprintf(shapePage{i}{j}); 
                %fprintf('\n'); 
                a = regexp(shapePage{i}{j}, ']');                
                if(a > 0)
                    shapePage{i}{j} = shapePage{i}{j}(a + 1:length(shapePage{i}{j})-1) ;
                end
                a = regexp(shapePage{i}{j}, 'R');           
                if(a == 1)
                    color = 1;
                else
                    a = regexp(shapePage{i}{j}, 'D');
                    if(a == 1)
                        color = 2;
                    else
                        color = 3;
                    end 
                end
                             
                                    
                %fprintf(shapePage{i}{j}); 
                %fprintf('\n'); 
                a = regexp(shapePage{i}{j}, 'k');
                if(a) > 0
                    shapePage{i}{j} = shapePage{i}{j}(a:length(shapePage{i}{j})) ;
                else                   
                    a = regexp(shapePage{i}{j}, 'c');
                    shapePage{i}{j} = shapePage{i}{j}(a+4:length(shapePage{i}{j})) ;
                end
                %fprintf(shapePage{i}{j}); 
                %fprintf('\n'); 
				if (regexp(shapePage{i}{j}, 'r')) == 1
                    dark = 0;
                elseif (regexp(shapePage{i}{j}, 'k')) == 1
                    dark = 1;
                end
                shapePage{i}{j} = shapePage{i}{j}(2:length(shapePage{i}{j})) ;
                %fprintf(shapePage{i}{j}); 
                %fprintf('\n'); 
				x = str2double(shapePage{i}{j});
				y = str2double(shapePage{i}{j + 1});
			elseif regexp(shapePage{i}{j}, 'line') == 1	% process "line" segment
				pS = [str2double(shapePage{i}{j - 2}), str2double(shapePage{i}{j - 1})];
				pE = [str2double(shapePage{i}{j + 1}), str2double(shapePage{i}{j + 2})];
				ori = [0 0];
               
				[px, py] = PlotContourSeg_Step(pS, pE, 0, ori, 0, arcStep);
				x = [x px];
				y = [y py];
			elseif regexp(shapePage{i}{j}, 'arc') == 1	% process "arc" segment
				if regexp(shapePage{i}{j + 3}, 'CW') == 1
					CW = 1;	% clockwise
				else
					CW = 0;	% counterclockwise
				end
				pS = [str2double(shapePage{i}{j - 2}), str2double(shapePage{i}{j - 1})];
				pE = [str2double(shapePage{i}{j + 5}), str2double(shapePage{i}{j + 6})];
				ori = [str2double(shapePage{i}{j + 1}), str2double(shapePage{i}{j + 2})];
                
                wrong = Lost_Dart(pS, pE, ori, CW);
                
				[px, py] = PlotContourSeg_Step(pS, pE, 1, ori, CW, arcStep);
				x = [x px];
				y = [y py];
			end
		end
		x = real(x);
		y = real(y);
		
		% start to paint
		if enMappingTOOLBOX	% "ispolycw" function can't be used in "acadamic" MATLAB
			if ispolycw(x, y)
				fill(x + SPACING * moveStep, y, 'b');	% paint polts of "DARK" shape
			else
				fill(x + SPACING * moveStep, y, 'w');	% paint polts of "CLEAR" shape
			end		
		else
			if (dark == 1)
                if(color ==1)            
                    fill(x + SPACING * moveStep, y, 'r');     
                end
                if (color ==2)
                        fill(x + SPACING * moveStep, y, 'g');
                end
                if (color ==3)
                        fill(x + SPACING * moveStep, y, 'b');
                end
            elseif (dark == 0)
                 fill(x + SPACING * moveStep, y, 'w');
            
            end
			% plot(x + SPACING * moveStep, y, 'b--o');
		end
		
	end

	% save "Figure1" to "output.bmp"
	%print('-f1', fileName, '-dbmp'); 

	toc
end
% end
		

