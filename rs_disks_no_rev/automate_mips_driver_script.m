%%%% 11-MAY-2023: Code simulates a collection of reciprocal swimming disks
%%%% (RS disks) whose self-propulsion speeds undergo fluctuations at 
%%%% an angular frequency \omega. No directional reversals.
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


tsteps=1e1; %number of simulation steps
dt=1e-1; %time-step width used for numerical integration integration

pbc_flag=1;
hs_flag=1; %set equal to 0 if you want to simulate phantom disks

u_bar=0.1; % magnitude of speed; same for all particles
D_r=[1e-3]; %rotational diffusivity
omeg=[D_r(1),0.1*D_r(1),10*D_r(1),100*D_r(1)]; %rate constant for Poisson process, speed fluctuation

num_d_r=length(D_r);
num_omeg=length(omeg);
                                
for i=1:num_d_r
    for j=1:num_omeg
        
        
        pos=zeros(tsteps+1,N,2); %stores x and y position of particles
        theta_all=zeros(tsteps+1,N,1);
        [pos,theta_all] = init_pos_ori(pos,theta_all,L,N); %initialization of positions and orientations
        
        
        %% evaluation of initial instantaneous velocities of all particles
        vmag0=u_bar;
        vel_all=vmag0*ones(tsteps+1,N,2); %stores components of the velocity
        vel_all(1,:,1)=vmag0*cos(theta_all(1,:,1));
        vel_all(1,:,2)=vmag0*sin(theta_all(1,:,1));
        
        
        pm_ind=[1:N];
        inert_ind=[];
        
        
        [pos,theta_all,vel_all] = function_for_sim(L,N,u_bar,D_r(i),...
        pos,theta_all,vel_all,...
        dt,tsteps,pbc_flag,hs_flag,...
        omeg(j),rad_disk,pm_ind);
        
        
        op_name=sprintf('test_folder/L%d_hs_%d_N%d_pos_u_0_%.2f_D_r_%g_omeg_%g_tsteps_%d_dt_%4.4f.mat',L,hs_flag,N,u_bar,D_r(i),omeg(j),tsteps,dt);
        save(op_name,'pos','-v7.3');


    end

end





