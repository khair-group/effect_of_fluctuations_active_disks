function [pos,theta_all,vel_all] = function_for_sim(L,N,u_bar,D_r,...
                                    pos,theta_all,vel_all,...
                                    dt,tsteps,pbc_flag,hs_flag,...
                                    omeg,rad_disk,pm_ind)


    % L    : we consider a periodic box of size L x L
    % N    : no. of particles in the box
    % rad_disk : radius of disk 
    rho=N./(L*L);
    dia_disk=2.*rad_disk;
    


    x0=pos(1,:,1);
    y0=pos(1,:,2);
    theta0=theta_all(1,:);
    

    max_iter=2*N;
    
    %%%%% implementing Heyes-Melrose at t=0
    x_op=x0;
    y_op=y0;
    contact_list=[1]; %for hard-sphere implementation
    unique_contacts=[];
    num_iter=0; %for hard-sphere implementation
    
    if pbc_flag==1
        x_op(x_op<0) = L + x_op(x_op<0);
        x_op(L<x_op) = x_op(L<x_op) - L;
        y_op(y_op<0) = L + y_op(y_op<0);
        y_op(L<y_op) = y_op(L<y_op) - L;
    end
    
    while(~isempty(contact_list) && num_iter<max_iter)
        if(~hs_flag)
            break
        end
        num_iter=num_iter+1;
        [D] = alt_min_img_conv(x_op,y_op,L,pbc_flag);
        [v_hs,contact_list] = pick_disks_in_contact(x_op,y_op,N,D,dia_disk,hs_flag,dt,L);
        unique_contacts=unique(contact_list);
        x_op=x_op+(v_hs(:,1).*dt)';
        y_op=y_op+(v_hs(:,2).*dt)';
    end
    
    x=x_op;
    y=y_op;

    pos(1,:,1)=x;
    pos(1,:,2)=y;
        
       for time=1:tsteps
        time
        num_iter=0; %for hard-sphere implementation
        contact_list=[1]; %for hard-sphere implementation
        unique_contacts=[];
        x=pos(time,:,1);
        y=pos(time,:,2);
        theta=theta_all(time,:);
        v=vel_all(time,:,:);
        
        
        vmag_inst=zeros*ones(1,N);
        %% evaluation of instantaneous velocity

        vmag_inst(pm_ind)=u_bar*cos(omeg*time*dt);
        theta(pm_ind)=theta(pm_ind)+(sqrt(2*D_r)*ret_theta_gauss_dist(length(pm_ind),dt));
        
        x = x  + vmag_inst.*cos(theta)*dt;
        y = y  + vmag_inst.*sin(theta)*dt;


        if pbc_flag==1
            x(x<0) = L + x(x<0);
            x(L<x) = x(L<x) - L;
            y(y<0) = L + y(y<0);
            y(L<y) = y(L<y) - L;
        end
        %
        x_op=x;
        y_op=y;
        
        while(~isempty(contact_list) && num_iter<max_iter)
            if(~hs_flag)
                break
            end
            num_iter=num_iter+1;
            [D] = alt_min_img_conv(x_op,y_op,L,pbc_flag);
            [v_hs,contact_list] = pick_disks_in_contact(x_op,y_op,N,D,dia_disk,hs_flag,dt,L);
            unique_contacts=unique(contact_list);
            x_op=x_op+(v_hs(:,1).*dt)';
            y_op=y_op+(v_hs(:,2).*dt)';
        end
        
        x=x_op;
        y=y_op;

        pos(time+1,:,1)=x;
        pos(time+1,:,2)=y;
        theta_all(time+1,:)=theta;
        vel_all(time+1,:,1)=vmag_inst.*cos(theta);
        vel_all(time+1,:,2)=vmag_inst.*sin(theta);

   
       end
   
end
