classdef LCD <matlab.System & matlab.system.mixin.Propagates ...
        & coder.ExternalDependency ...
        & matlab.system.mixin.internal.CustomIcon 
        
%LCD: Displays two string on a connected 16x2 char LCD screen such as the 
%jhd162A module. Given two input strings that are casted to uint8, an upper 
%and lower string, the two strings are displayed on the upper and lower 
%rows of the screen respectively.
    
    %#codegen
    %#ok<*EMCA>
    
    properties (Nontunable) 
%        pins = [1,2];%{'SCL','SDA'};
    end
    
    properties (Hidden)
        simSampleNum = single(0);
    end
    methods
        % Constructor
        function obj = LCD(varargin)
            coder.allowpcode('plain');
        end
        
    end
    methods(Access = protected)
        function setupImpl(obj)
            if coder.target('Rtw')
%                 pins8 = uint8(obj.pins);
                coder.cinclude('LCD_sim.h');
                coder.ceval('MW_LCD_Init');%pins8(1),pins8(2),pins8(3),pins8(4),pins8(5),pins8(6));
            end
        end
        
        function stepImpl(obj,line1str,line2str)
            
            line1str = uint8(line1str);
            str1 = char(line1str);
            line1Cstr = [str1(:)' 0];
            
            line2str = uint8(line2str);
            str2 = char(line2str);
            line2Cstr = [str2(:)' 0];
            
            if coder.target('Rtw')
                coder.ceval('MW_Print_LCD',line1Cstr,line2Cstr);
            else
                
            end
        end
        
        function maskDisplayCmds = getMaskDisplayImpl(~)          
            maskDisplayCmds = { ...
                'color(''white'');',...
                'plot([100,100,100,100]*1,[100,100,100,100]*1);',...
                'plot([100,100,100,100]*0,[100,100,100,100]*0);',...
                'color(''black'');', ...
%                 'lcdroot = strrep(LiquidCrystalDisplay.internal.getLCDRootPath(),''\'',''/'');',...
                'image(''LCD.png'',''center'')'...
                'text(18,60, '' Line 1 '', ''horizontalAlignment'', ''center'',''verticalAlignment'', ''middle'');' ...
                'text(18,40, '' Line 2 '', ''horizontalAlignment'', ''center'',''verticalAlignment'', ''middle'');' ...
                'fprintf(''LCD'');'
                };
        end
    end
    
    
    methods (Static)
        function name = getDescriptiveName()
            name = '3 digit LCD display';
        end
        function b = isSupportedContext(context)
            b = context.isCodeGenTarget('rtw');
        end
        function updateBuildInfo(buildInfo, context)           
            if context.isCodeGenTarget('rtw')               
                srcDir = fullfile(fileparts(mfilename('fullpath')),'src'); % #ok
                includeDir = fullfile(fileparts(mfilename('fullpath')),'include');
                addIncludePaths(buildInfo,includeDir);
                % Use the following API's to add include files, sources and linker flags
                addSourceFiles(buildInfo,'LCD_sim.cpp', srcDir);
%                 addIncludeFiles(buildInfo,'LiquidCrystal_I2C.h',includeDir);
%                 addIncludeFiles(buildInfo,'Wire.h',includeDir);
                 addSourceFiles(buildInfo,'LiquidCrystal_I2C.cpp',includeDir);
            end
            
        end

    end
    
    methods(Static, Access = protected)
        % Note that this is ignored for the mask-on-mask
        function header = getHeaderImpl
            %getHeaderImpl Create mask header
            %   This only has an effect on the base mask.
            header = matlab.system.display.Header(mfilename('class'), ...
                'Title', '16 x 2 LCD Display', ...
                'Text', sprintf(['Display two rows of max 16 character strings.',...
                '\n\nThe block accepts two 1-D arrays of type uint8. The input values for Line 1 get diplayed in the top row. The input values for Line 2 get diplayed in the bottom row.',...
                '\n\n Connect the SCL SDA pins of LCD module to SCL SDA pins of Arduino']), ...
                'ShowSourceLink', false);
        end
        
%         function groups = getPropertyGroupsImpl(~)
%             % Define section for properties in System block dialog box.
%             pinsProp = matlab.system.display.Section(...
%                 'Description', ' Connect to SCL SDA Arduino Pins');
%             
%             Group = matlab.system.display.Section(...
%                 'Title', 'Parameters', 'PropertyList', ...
%                     {pinsProp});
%             groups = Group;
%         end
                function simMode = getSimulateUsingImpl(~)
            simMode = 'Interpreted execution';
        end
        
        function isVisible = showSimulateUsingImpl
            isVisible = false;
        end

    end
    
end