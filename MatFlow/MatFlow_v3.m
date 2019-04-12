function [struct ] = MatFlow_v3(struct)

%% MatFlow v3 %%
%   3D Groundwater Equation using Implicit Finite Difference Scheme 
%   Andy Banks 04/20/17 %



%% %% Compute Cell Centered Conductance Terms [L^2*t^-2] %% %%

struct = cell_cond(struct); %call cell_cond

%% Construct  {A} %%
struct= coeff_matrix(struct);

%% Solve {A}{h}={q}

struct.H=struct.A\struct.RHS';
% tol=0.1E-3;
% [struct.H,struct.PCGflag]=pcg(struct.A,struct.RHS',tol);



    

end