function [vmag_op] = ret_vmag_unif_dist(mu,del,num)
%Returns the magnitude of the velocity from a
%uniform distribution that is centred at "mu", and
%extends from [mu-del,mu+del];
a=mu-del;
b=mu+del;
vmag_op=a + (b-a).*rand(1,num);
end

