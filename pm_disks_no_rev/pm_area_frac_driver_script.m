%%%% 11-MAY-2023: Code simulates a collection of PM disks
%%%% whose self-propulsion speeds undergo fluctuations at 
%%%% update instances drawn from a Poissonian process
%%%% of rate constant \beta. The speeds are drawn from a power-law
%%%% distribution P(U)~U^{-\alpha} in the interval [U_0,n*U_0].
%%%% No directional reversals.
%%%%
%%%% In this driver script, various system sizes (N) are considered for
%%%% fixed values of \beta and D_{r}.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Backbone for Vicsek model simulation downloaded on 4th Oct 2022 from
%%% https://www.mathworks.com/matlabcentral/fileexchange/64208-vicsek-model-simulation
%%%

L=10; % we consider a periodic box of size L x L
N=[100,200,300]; % no. of particles in the box

rad_disk=0.2;
dia_disk=2.*rad_disk;
rho=N/(L*L);

tsteps=1e0;
dt=1e-4;

pbc_flag=1;
hs_flag=1;


dummy=size(N);
len_N=dummy(2);

v0=0.1; % magnitude of speed; same for all particles
n=1e4;
alph=1.5;
D_r=1e0; %rotational diffusivity
bet=1e3; %rate constant for Poisson process, speed fluctuation
                           
                                
for i=1:len_N    

    pos=zeros(tsteps+1,N(i),2); %stores x and y position of particles
    theta=zeros(1,N(i));
    [pos,theta] = init_pos_ori(pos,L,N(i)); %initialization of positions and orientations
    
    pm_ind=[1:N(i)];
    inert_ind=[];

    [pos] = function_for_sim_pwlaw(L,N(i),v0,n,alph,D_r,...
        			   pos,theta,...
        			   dt,tsteps,pbc_flag,hs_flag,...
        			   bet,rad_disk,pm_ind);

    
    op_name=sprintf('test_folder/L%d_hs_%d_N%d_pos_v0_%.2f_n_%d_f_D_r_%.2f_beta_%.2f_tsteps_%d_dt_%4.4f.mat',L,hs_flag,N(i),v0,n,D_r,bet,tsteps,dt);
    save(op_name,'pos','-v7.3');
   
end


