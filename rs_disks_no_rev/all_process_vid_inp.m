function [] = all_process_vid_inp(inp_file_name,skip_fac,op_name)


a=importdata(inp_file_name);
dim_res=size(a);
no_of_dimensions=length(dim_res);

if (no_of_dimensions==2) % we have only one trajectory
    num_files=1;
    num_lines=dim_res(1);
else % we have multiple trajectories
    num_lines=dim_res(1); %number of timesteps
    num_files=dim_res(2); %i.e., number of particles
end

tsteps=num_lines;
N=num_files;
z_op=zeros(1,N);

A=ones(1,N); % stores particle type for monodisperse suspension

fid=fopen(op_name,'a');

ct=0
for time=1:skip_fac:tsteps
    ct=ct+1
    time
    x_op=a(time,:,1);
    y_op=a(time,:,2);
    pos=[A' x_op' y_op' z_op'];
    fprintf(fid,'%d',N);
    fprintf(fid,'\n');
    fprintf(fid,'Lattice="10 0 0 0 10 0 0 0 10" Properties=type:I:1:pos:R:3 Origin "0 0 0" pbc="T T F"');
    writematrix(pos,op_name,'delimiter','tab','WriteMode','append');
end
fclose(fid);


end



