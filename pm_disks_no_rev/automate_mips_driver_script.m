%%%% 11-MAY-2023: Code simulates a collection of PM disks
%%%% whose self-propulsion speeds undergo fluctuations at 
%%%% update instances drawn from a Poissonian process
%%%% of rate constant \beta. The speeds are drawn from a power-law
%%%% distribution P(U)~U^{-\alpha} in the interval [U_0,n*U_0].
%%%% No directional reversals.
%%%%
%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Backbone for Vicsek model simulation downloaded on 4th Oct 2022 from
%%% https://www.mathworks.com/matlabcentral/fileexchange/64208-vicsek-model-simulation
%%%


L=10; % we consider a periodic box of size L x L
N=400; % no. of particles in the box

rad_disk=0.2;
dia_disk=2.*rad_disk;
rho=N/(L*L);


tsteps=2e1; %number of simulation steps
dt=1e-4; %time-step width used for numerical integration integration

pbc_flag=1;
hs_flag=1; %set equal to 0 if you want to simulate phantom disks

v0=0.1; % magnitude of speed; same for all particles
n=1e4;
alph=1.5; %exponent of the power-law distribution
D_r=[1e-3]; %rotational diffusivity
bet=[40000.*D_r(1), 20000.*D_r(1)]; %rate constant for Poisson process, speed fluctuation


num_d_r=length(D_r);
num_bet=length(bet);
                                
for i=1:num_d_r
    for j=1:num_bet
        
        pos=zeros(tsteps+1,N(i),2); %stores x and y position of particles
        theta=zeros(1,N(i));
        [pos,theta] = init_pos_ori(pos,L,N(i)); %initialization of positions and orientations


        pm_ind=[1:N(i)];
        inert_ind=[];
       
        
        [pos] = function_for_sim_pwlaw(L,N,v0,n,alph,D_r(i),...
        				pos,theta,...
        				dt,tsteps,pbc_flag,hs_flag,...
        				bet(j),rad_disk,pm_ind);

        
        op_name=sprintf('test_folder/L%d_hs_%d_N%d_pos_v0_%.2f_n_%d_f_D_r_%g_beta_%g_tsteps_%d_dt_%4.4f.mat',L,hs_flag,N,v0,n,D_r(i),bet(j),tsteps,dt);
        save(op_name,'pos','-v7.3');

    end

end





