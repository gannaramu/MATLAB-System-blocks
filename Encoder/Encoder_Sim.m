classdef Encoder_Sim < matlab.System ...
        & coder.ExternalDependency ...
        & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
   
%LCD: Displays two string on a connected 16x2 char LCD screen such as the 
%jhd162A module. Given two input strings that are casted to uint8, an upper 
%and lower string, the two strings are displayed on the upper and lower 
%rows of the screen respectively.
    
    properties
        % Public, tunable properties.
    end
    
    properties (Nontunable)
         % Pin Number 1
         pinNumber1 = 5;
         % Pin Number 2
         pinNumber2 = 6;

         
    end
    
    properties (Access = private)
        % Pre-computed constants.
    end
    
    methods
        % Constructor
        function obj = Encoder_Sim(varargin)
            % Support name-value pair arguments when constructing the object.
            setProperties(obj,nargin,varargin{:});
            %error("looking for liscence")
        end
    end
    
    methods (Access=protected)
        function setupImpl(obj) %#ok<MANU>

            if isempty(coder.target)
                % Place simulation setup code here
            else
                % Call C-function implementing device initialization
                % coder.cinclude('sink.h');
                % coder.ceval('sink_init');
%                disp( [ "Roboholic Liscence for " getenv('COMPUTERNAME')]); % for windows
                
                coder.cinclude('Encoder_Sim.h');
                               
                coder.ceval('Encoder_init',0,obj.pinNumber1,obj.pinNumber2);
 %coder.ceval('digitalIOSetup', 9, 0);
 
            end
        end
        
        function reading = stepImpl(obj)  %# ok<INUSD>
            reading = double(0);     

        
            
            if isempty(coder.target)
                % Place simulation output code here 
            else
                % Call C-function implementing device output
                %coder.ceval('MPU_update');
                reading = coder.ceval('Encoder_step',0); % coder.ceval('Encoder_read');
                

                %coder.ceval('writeDigitalPin', 13, u);

            end
        end
        
        function releaseImpl(obj) %#ok<MANU>
            if isempty(coder.target)
                % Place simulation termination code here
            else
                % Call C-function implementing device termination
                %coder.ceval('sink_terminate');
            end
        end
    end
    
    methods (Access=protected)
        %% Define input properties
        function num = getNumInputsImpl(~)
            num = 0;
        end
        
        function num = getNumOutputsImpl(~)
            num = 1;
        end
        function flag = isOutputSizeLockedImpl(~,~)
            flag = true;
        end
        
        function varargout = isOutputFixedSizeImpl(~,~)
            varargout{1} = true;
            

        end
        
        
        function varargout = isOutputComplexImpl(~)
             varargout{1} = false;
            
        end
        
        function varargout = getOutputSizeImpl(~)
            varargout{1} = [1,1];
            
        end
        
        function varargout = getOutputDataTypeImpl(~)
            varargout{1} = 'double';
        end

        
        function icon = getIconImpl(~)
            % Define a string as the icon for the System block in Simulink.
            icon =  matlab.system.display.Icon("Encoder-Basics-1.jpg");
            
        end
    end
    
    methods (Static, Access=protected)
        function simMode = getSimulateUsingImpl(~)
            simMode = 'Interpreted execution';
        end
        
        function isVisible = showSimulateUsingImpl
            isVisible = false;
        end
        function header = getHeaderImpl
            %getHeaderImpl Create mask header
            %   This only has an effect on the base mask.
            header = matlab.system.display.Header(mfilename('class'), ...
                'Title', 'Encoder', ...
                'Text', sprintf(['This block gives the counter reading from the encoder sensor connected to the arduino.']), ...
                'ShowSourceLink', false);
        end
        function groups = getPropertyGroupsImpl
            valueGroup = matlab.system.display.Section(...
                'Title','Arduino Pin Connections',...
                'PropertyList',{'pinNumber1','pinNumber2'});
            
           
            groups = [valueGroup];
        end
    end
    
    methods (Static)
        function name = getDescriptiveName()
            name = 'Encoder';
        end
        
        function b = isSupportedContext(context)
            b = context.isCodeGenTarget('rtw');
        end
        
        function updateBuildInfo(buildInfo, context)
            if context.isCodeGenTarget('rtw')
                % Update buildInfo
                srcDir = fullfile(fileparts(mfilename('fullpath')),'src'); % #ok
                includeDir = fullfile(fileparts(mfilename('fullpath')),'include');
                addIncludePaths(buildInfo,includeDir);
                % Use the following API's to add include files, sources and linker flags
                addSourceFiles(buildInfo,'Encoder_Sim.cpp', srcDir);
                % Use the following API's to add include files, sources and
                % linker flags
                %addIncludeFiles(buildInfo,'source.h',includeDir);
                %addSourceFiles(buildInfo,'source.c',srcDir);
                %addLinkFlags(buildInfo,{'-lSource'});
                %addLinkObjects(buildInfo,'sourcelib.a',srcDir);
                %addCompileFlags(buildInfo,{'-D_DEBUG=1'});
                %addDefines(buildInfo,'MY_DEFINE_1')
            end
        end
    end
end
