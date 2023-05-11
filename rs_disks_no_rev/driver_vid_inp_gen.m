%%% routine to generate dat files needed for video creation, 
%%% from mat file generated as simulation output

dt=1e-1;
L=10;
pbc_flag=1;

skip_fac=1;

myFolder='test_folder';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isfolder(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s\nPlease specify a new folder.', myFolder);
    uiwait(warndlg(errorMessage));
    myFolder = uigetdir(); % Ask for a new one.
    if myFolder == 0
         % User clicked Cancel
         return;
    end
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, 'L10_*.mat'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
chk={theFiles.name};
str_inp=string(chk);
%sorted_fname_list=natsortfiles(str_inp);

sorted_fname_list=(str_inp);


op_folder='test_folder';


for k = 1 : length(theFiles) %loop through files and perform the desired operation

    baseFileName = sorted_fname_list(k);
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    
    vid_inp_name=strcat('vid_inp_',baseFileName);
    vid_inp_name=strrep(vid_inp_name,'mat','dat');
    
   
    op_name=fullfile(theFiles(k).folder,vid_inp_name);
    all_process_vid_inp(fullFileName,skip_fac,op_name);    
    
end

