classdef DHT < matlab.System ...
        & coder.ExternalDependency ...
        & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
     
    properties
        % Sensor Pin
         Pin = 5;
         
         
    end
     properties (Nontunable)
        % DHT sensor Type
        StringChoice = 'DHT11';
        
     end
     properties (Logical,Nontunable)
        % Read in Fahrenheit
        F = false;
        
    end
    
    properties (Access = private)
        % Pre-computed 
        Sensor;
    end
    
    properties (Hidden, Constant)
        StringChoiceSet = matlab.system.StringSet({'DHT11','DHT22','DHT21'});
        % Pre-computed constants.
    end
    
    properties (Access = private)
        % Pre-computed constants.
    end
    
    methods
        % Constructor
        function obj = DHT(varargin)
            % Support name-value pair arguments when constructing the object.
            setProperties(obj,nargin,varargin{:});
            %error("looking for liscence")
           
        end
    end
    
    methods (Access=protected)
        function setupImpl(obj) %#ok<MANU>
%             disp(obj.StringChoice)
                switch obj.StringChoice
                    case 'DHT11'
                        obj.Sensor=11;
                    case 'DHT22'
                        obj.Sensor=22;
                    case 'DHT21'
                        obj.Sensor=21;
                end
%                 disp(obj.Sensor);
            if isempty(coder.target)
                % Place simulation setup code here
            else
                % Call C-function implementing device initialization
                % coder.cinclude('sink.h');
                % coder.ceval('sink_init');
                %                disp( [ "Roboholic Liscence for " getenv('COMPUTERNAME')]); % for windows
                
                coder.cinclude('dht_sim.h');
                coder.ceval('setDHT', uint8(obj.Pin), uint8(obj.Sensor));
            end
        end
        
        function [Humidity, Temperature] = stepImpl(obj)  %# ok<INUSD>
            Humidity = single(0);   
            Temperature = single(0);

        
            
            if isempty(coder.target)
                % Place simulation output code here 
            else
                Humidity = coder.ceval('readHumidity');
                if obj.F % if in Fahrenheit
                    Temperature = coder.ceval('readTempF');
                    
                else % if in Celsius
                    Temperature = coder.ceval('readTemp');
                   
                end
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
            num = 2;
        end
        function flag = isOutputSizeLockedImpl(~,~)
            flag = true;
        end
        
        function varargout = isOutputFixedSizeImpl(~,~)
            varargout = {true,true};
        end
        
        
        function varargout = isOutputComplexImpl(~)
             varargout{1} = false;
             varargout{2} = false;
 end
        
        function varargout = getOutputSizeImpl(~)
            varargout{1} = [1,1];
            varargout{2} = [1,1];
        end
        
        function varargout = getOutputDataTypeImpl(~)
            varargout{1} = 'single';
            varargout{2} = 'single';

        end

        
        function icon = getIconImpl(~)
            % Define a string as the icon for the System block in Simulink.
            icon =  matlab.system.display.Icon("DHT.jpg");
            
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
                'Title', 'DHT Sensor', ...
                'Text', sprintf(['This blocks gives the Humidity and Temperature readings from the DHT sensor connected to the arduino']), ...
                'ShowSourceLink', false);
         end
        function groups = getPropertyGroupsImpl
            valueGroup = matlab.system.display.Section(...
                'Title','Arduino Pin Connections',...
                'PropertyList',{'Pin','StringChoice','F'});
            
           
            groups = [valueGroup];
        end
    end
    
    methods (Static)
        function name = getDescriptiveName()
            name = 'DHT';
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
                addSourceFiles(buildInfo,'dht_sim.cpp', srcDir);
                addSourceFiles(buildInfo,'Dht.cpp', includeDir);                                
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
