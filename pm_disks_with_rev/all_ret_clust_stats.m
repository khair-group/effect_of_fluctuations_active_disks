function [num_clust_info,large_clust_info] = all_ret_clust_stats(inp_file_name,pbc_flag,contact_dist,skip_fac,L,dt)
% Returns the hexatic order parameter, based on the formulae presented 
% in ﻿PRL 108, 168301 (2012).
% does not differntiate between the various species in the system;
% calculates the order parameter over all the species


a=importdata(inp_file_name);
dim_res=size(a);
no_of_dimensions=length(dim_res);
num_lines=dim_res(1);
num_files=dim_res(2);
N=num_files;
tsteps=num_lines;

frame_list=1:skip_fac:tsteps;
ser_n_clust=zeros(1,length(frame_list));
ser_large_clust=zeros(1,length(frame_list));

it_num=1;


for t=1:skip_fac:num_lines
%     t
    pos=squeeze(a(t,:,:));
    %%% the following segment does the cluster stat analysis
    %%% after implementing the minimum image convention
    [D] = alt_min_img_conv(pos(:,1),pos(:,2),10.,pbc_flag);   
    [T,dist_table,n_clust,pop_large] = ret_stats_clust_analysis(D,contact_dist);
    ser_n_clust(it_num)=n_clust;
    ser_large_clust(it_num)=pop_large;
    it_num=it_num+1;
end

num_clust_info=[dt*frame_list;ser_n_clust];
large_clust_info=[dt*frame_list;ser_large_clust];

end

