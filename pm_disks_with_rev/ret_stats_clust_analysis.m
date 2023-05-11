function [T,dist_table,n_clust,pop_large] = ret_stats_clust_analysis(D,mean_dia)


% The input "pos" is simply the x and y coordinates of the
% droplets at a particular time instance.
%
%
% "mean_dia" used to decide the cutoff distance. 

Y = squareform(D);
Z = linkage(Y);
T = cluster(Z,'Criterion','distance','Cutoff',mean_dia);

[b,a] = groupcounts(T); %distribution
dist_table=[a,b];

n_clust=length(dist_table);     % number of clusters
pop_large=max(dist_table(:,2)); % population of largest cluster

end

