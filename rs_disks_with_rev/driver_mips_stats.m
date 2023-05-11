%%% 11-MAY-2023: Driver routine to perform cluster analysis on a
%%% time-series of simulation ouput. 
%%%
%%%
%%%

rad_disk=0.2;
dia=2.*rad_disk;
contact_dist=1.05*dia;
skip_fac=1; % processing time-series of simulation data at intervals of "skip_fac" for cluster analysis.
dt=0.1;
L=10.;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inp_folder='test_folder'; %input folder with simulation output
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isfolder(inp_folder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s\nPlease specify a new folder.', inp_folder);
    uiwait(warndlg(errorMessage));
    inp_folder = uigetdir(); % Ask for a new one.
    if inp_folder == 0
         % User clicked Cancel
         return;
    end
end



% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(inp_folder, 'L10*.mat'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
chk={theFiles.name};
str_inp=string(chk);
sorted_fname_list=natsortfiles(str_inp);

op_folder='test_folder'; %output folder to which results of cluster analysis would be saved

%%%%% process the instantaneous velocity information
%%%%% to be passed on to the image generation routine
%%%%% so that the arrow is drawn appropriately.



for k = 1 : length(theFiles)
    k
    baseFileName = sorted_fname_list(k);
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    a=importdata(fullFileName);
    opFileName_clust = strcat('largest_clust_',baseFileName);
    opFileName_num = strcat('num_',baseFileName);
    fullFileName_clust = fullfile(theFiles(k).folder, opFileName_clust);
    fullFileName_num = fullfile(theFiles(k).folder, opFileName_num);
    [num_clust_info,large_clust_info] = calc_save_clust_stats(a,contact_dist,fullFileName_clust,fullFileName_num,skip_fac,L,dt);
end




