function [num_clust_info,large_clust_info] = calc_save_clust_stats(a,contact_dist,clust_name,num_name,skip_fac,L,dt)

%%% Processes the simulation trajectories stored in .mat files, and
%%% calculates and saves the cluster statistics

dim_res=size(a);
no_of_dimensions=length(dim_res);

if (no_of_dimensions==2) % we have only one trajectory
    N=1;
    tsteps=dim_res(1);
else % we have multiple trajectories
    tsteps=dim_res(1);
    N=dim_res(2); %i.e., number of particles
end

pbc_flag=1;


frame_list=1:skip_fac:tsteps;
ser_n_clust=zeros(1,length(frame_list));
ser_large_clust=zeros(1,length(frame_list));

it_num=1;

for t=1:skip_fac:tsteps
   
    t    
    pos=squeeze(a(t,:,:));
    %%% the following segment does the cluster stat analysis
    %%% after implementing the minimum image convention
    [D] = alt_min_img_conv(pos(:,1),pos(:,2),L,pbc_flag);
    
    [T,dist_table,n_clust,pop_large] = ret_stats_clust_analysis(D,contact_dist);
    ser_n_clust(it_num)=n_clust;
    ser_large_clust(it_num)=pop_large;
    it_num=it_num+1;
end

num_clust_info=[dt*frame_list;ser_n_clust];
save(num_name,'num_clust_info');

large_clust_info=[dt*frame_list;ser_large_clust];
save(clust_name,'large_clust_info');

end
