function blkStruct = slblocks
  % Specify that the product should appear in the library browser
  % and be cached in its repository
  	Browser.Library = 'RoboholicLib';
		% 'mylib' is the name of the library

		Browser.Name = 'Roboholic Maniacs Arduino Support Package';
		% 'My Library' is the library name that appears 
             % in the Library Browser

		blkStruct.Browser = Browser; 
% % 
% %   blkStruct.OpenFcn  = 'RoboholicLib.slx';
% %   blkStruct.MaskDisplay = '';
% % 
% %   Browser(1).Library = 'RoboholicLib';
% %   Browser(1).Name    = 'Roboholic Maniacs Arduino Support Package'; 
  
