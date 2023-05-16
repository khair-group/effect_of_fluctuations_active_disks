# effect_of_fluctuations_active_disks
Codes for simulating active disks with speed fluctuations in 2D

There are four directories in the folder, one for each category of speed fluctuation considered in this project.
The names of the MATLAB scripts that perform essentially the same function have been kept the same across directories.

For instance, 

+ The "automate_mips_driver_script.m" in each directory simulates a collection of sterically repulsive disks. Setting hs_flag=0
  in this script would simulate a collection of phantom disks, useful for comparison against analytical single disk results       where available. 

+ "driver_mips_stats.m" implements hierarchical cluster analysis 
  [Additional info:https://www.mathworks.com/help/stats/hierarchical-clustering.html] on the simulation data, to return a time-   series of the largest cluster and number of clusters in the suspension.

+ "driver_vid_inp_gen.m" processes the simulation output in a form that may be read by Ovito, for video generation.

The code "pm_area_frac_driver_script.m" is present only in the "pm_disks_no_rev" folder, and simulates a collection of PM disks at various area fractions.

