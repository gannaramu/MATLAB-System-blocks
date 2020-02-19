classdef MPU6050 < matlab.System ...
        & coder.ExternalDependency ...
        & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
    %
    % System object template for a sink block.
    % 
    % This template includes most, but not all, possible properties,
    % attributes, and methods that you can implement for a System object in
    % Simulink.
    %
    % NOTE: When renaming the class name Sink, the file name and
    % constructor name must be updated to use the class name.
    %
    % Copyright 2016-2018 The MathWorks, Inc.
    %#codegen
    %#ok<*EMCA>
    
    properties
        % Public, tunable properties.
    end
    
    properties (Nontunable)
        % Public, non-tunable properties.
    end
    
    properties (Access = private)
        % Pre-computed constants.
    end
    
    methods
        % Constructor
        function obj = MPU6050(varargin)
            % Support name-value pair arguments when constructing the object.
            setProperties(obj,nargin,varargin{:});
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
%                 disp( [ "Roboholic Liscence for " getenv('COMPUTERNAME')]); % for windows
%                 
                coder.cinclude('MPU_6050.h');
                               
                coder.ceval('MPU_setup');

 
            end
        end
        
        function [acc_x,acc_y,acc_z,...
                    gyro_x,gyro_y,gyro_z,...
                    acc_angl_x,acc_angl_y,...
                    gyro_angl_x,gyro_angl_y,gyro_angl_z,...
                    angl_x,angl_y,angl_z,temp] = stepImpl(obj)  %# ok<INUSD>
            acc_x = double(0);
            acc_y = double(0);
            acc_z = double(0);
            
            gyro_x = double(0);
            gyro_y = double(0);
            gyro_z = double(0);
            
            acc_angl_x = double(0);
            acc_angl_y = double(0);

            gyro_angl_x = double(0);
            gyro_angl_y = double(0);
            gyro_angl_z = double(0);

            angl_x = double(0);
            angl_y = double(0);
            angl_z = double(0);

            temp =double(0);
            
            if isempty(coder.target)
                % Place simulation output code here 
            else
                % Call C-function implementing device output
                coder.ceval('MPU_update');
                acc_x = coder.ceval('get_accx_data');
                acc_y = coder.ceval('get_accy_data');
                acc_z = coder.ceval('get_accz_data');
                
                gyro_x = coder.ceval('get_gyroX_data');
                gyro_y = coder.ceval('get_gyroY_data');
                gyro_z = coder.ceval('get_gyroZ_data');
                
                acc_angl_x = coder.ceval('get_acc_angle_x_data');
                acc_angl_y = coder.ceval('get_acc_angle_y_data');
                
                gyro_angl_x = coder.ceval('get_gyro_angle_X_data');
                gyro_angl_y = coder.ceval('get_gyro_angle_Y_data');
                gyro_angl_z = coder.ceval('get_gyro_angle_Z_data');
                
                angl_x = coder.ceval('get_angle_X_data');
                angl_y = coder.ceval('get_angle_Y_data');
                angl_z = coder.ceval('get_angle_Z_data');
                
                temp = coder.ceval('get_temp_data');


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
            num = 15;
        end
        function flag = isOutputSizeLockedImpl(~,~)
            flag = true;
        end
        
        function varargout = isOutputFixedSizeImpl(~,~)
            varargout{1} = true;
            varargout{2} = true;
            varargout{3} = true;
            varargout{4} = true;
            varargout{5} = true;
            varargout{6} = true;
            varargout{7} = true;
            varargout{8} = true;
            varargout{9} = true;
            varargout{10} = true;
            varargout{11} = true;
            varargout{12} = true;
            varargout{13} = true;
            varargout{14} = true;
            varargout{15} = true;

        end
        
        
        function varargout = isOutputComplexImpl(~)
             varargout{1} = false;
            varargout{2} = false;
            varargout{3} = false;
            varargout{4} = false;
            varargout{5} = false;
            varargout{6} = false;
            varargout{7} = false;
            varargout{8} = false;
            varargout{9} = false;
            varargout{10} = false;
            varargout{11} = false;
            varargout{12} = false;
            varargout{13} = false;
            varargout{14} = false;
            varargout{15} = false;

        end
        
        function varargout = getOutputSizeImpl(~)
            varargout{1} = [1,1];
            varargout{2} = [1,1];
            varargout{3} = [1,1];
            varargout{4} = [1,1];
            varargout{5} = [1,1];
            varargout{6} = [1,1];
            varargout{7} = [1,1];
            varargout{8} = [1,1];
            varargout{9} = [1,1];
            varargout{10} = [1,1];
            varargout{11} = [1,1];
            varargout{12} = [1,1];
            varargout{13} = [1,1];
            varargout{14} = [1,1];
            varargout{15} = [1,1];
           
        end
        
        function varargout = getOutputDataTypeImpl(~)
            varargout{1} = 'double';
            varargout{2} = 'double';
            varargout{3} = 'double';
            varargout{1} = 'double';
            varargout{2} = 'double';
            varargout{3} = 'double';
            varargout{4} = 'double';
            varargout{5} = 'double';
            varargout{6} = 'double';
            varargout{7} = 'double';
            varargout{8} = 'double';
            varargout{9} = 'double';
            varargout{10} = 'double';
            varargout{11} = 'double';
            varargout{12} = 'double';
            varargout{13} = 'double';
            varargout{14} = 'double';
            varargout{15} = 'double';
        end

        
        function icon = getIconImpl(~)
            % Define a string as the icon for the System block in Simulink.
            icon =  matlab.system.display.Icon("MPU6050.png");
            
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
                'Title', 'MPU 6050', ...
                'Text', sprintf(['This blocks gives the Accelerometer, Gyrometer readings in all the 3 axis i.e. X, Y and Z axes from the MPU6050 IMU connected to the arduino via I2C',...
                '\n\nConnect the SCL SDA pins of the MPU6050 to the Arduino respectively.']), ...
                'ShowSourceLink', false);
         end
        
    end
    
    methods (Static)
        function name = getDescriptiveName()
            name = 'MPU6050';
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
                addSourceFiles(buildInfo,'MPU_6050.cpp', srcDir);
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
