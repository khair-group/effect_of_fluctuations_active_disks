function [v_hs,contact_list] = pick_disks_in_contact(xval,yval,N,D,contact_dist,hs_flag,dt,L)
% Takes in the inter-particle distances at a given time-frame.
% Returns a list of particles that are within a distance "contact_dist"
% of each other, i.e., those that are overlapping

sftness=0.01*contact_dist;

pot_strength=(0.5);
M_near = D; %Matrix representation for the distance between particles
[l1,l2]=find((M_near+sftness<contact_dist) & (M_near>0));

contact_list=[];
v_hs=zeros(N,2);

for i = 1:N
    list = l1(l2==i);
    if ~isempty(list)
        n_list=length(list);
        contact_list=[contact_list,list'];
        if(hs_flag)
            for k=1:n_list
                dy=yval(list(k))-yval(i);
                dx=xval(list(k))-xval(i);
                if (dx > 0.5*L)
                    dx = dx - L;
                end
                if (dx < (-0.5*L))
                    dx = dx + L;
                end
                % similarly for the y-coordinate
                if (dy > 0.5*L)
                    dy = dy - L;
                end
                if (dy < (-0.5*L))
                    dy = dy + L;
                end
                phi=atan2(dy,dx);
                dist_temp=M_near(i,list(k));
                v_hs(i,1)=v_hs(i,1)+((pot_strength/dt)*(dist_temp-contact_dist)*cos(phi));
                v_hs(i,2)=v_hs(i,2)+((pot_strength/dt)*(dist_temp-contact_dist)*sin(phi));
            end
        end
    end
end
        

end

