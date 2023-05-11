function [samp_vec] = ret_pwlaw_nums(v_low,v_hi,alph,num_samples)

%%%% see StackOverFlow answer: 
%%% https://stackoverflow.com/questions/31114330/python-generating-random-numbers-from-a-power-law-distribution
g=1-alph;

v_rand=rand(1,num_samples);
b_g=v_hi^g;
a_g=v_low^g;
sc_v=(a_g+((b_g-a_g)*v_rand));
samp_vec=sc_v.^(1./g);
end

