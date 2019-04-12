function [struct ] = coeff_matrix(struct)

%% coff_matrix for MatFlow v3 %

% function that build A matrix in {A}{h}={q}
%   -objective is to construct a matrix B that allows us to compute the
%    coefficents for the main diagonal of A, by summing across the rows of B
%% call discretization , conductance and source/sink  variables %%

ncol=struct.ncol;
nrow=struct.nrow;
nlay=struct.nlay;

dv=struct.dv;
dr=struct.dr;
dc=struct.dc;

CR=struct.CR;
CC=struct.CC;
CV=struct.CC;

p=struct.p; %p(:,2)=zeros(size(struct.p));%MODIFY p,q IF PUMPAGE IS NOT FROM SINGLE LAYER
q=struct.q; %q(:,2)=zeros(size(struct.q));

%% Build Coefficent Matrix Terms %%

struct.P=p;                 %sum across columns to get total head/flow dependency terms
struct.Q=q;                 %sum across columns to get net flow for each cell
struct.V=struct.dr.*struct.dv.*struct.dc;               %compute cell volumes [L^3]
struct.SC1=struct.Ss.*struct.V;                  %compute storage coefficents [L^2]
struct.HCOF=struct.P-struct.SC1./struct.dt;             %compute HCOF for each cell, [L^2*t^-1]
struct.RHS=-struct.Q-struct.SC1.*struct.H0./struct.dt;         %construct RHS of {A}{h}={q}



%% Compute centeral matrix terms %%

H=diag(struct.HCOF,0);                                                                    %put HCOF on main diagonal of B
R=diag(struct.CR(1:end-1),-1)+diag(struct.CR(1:end-1),1);                                 %put row conductances on first super and subdiagonal
C=diag(struct.CC(1:end-ncol),-ncol)+diag(struct.CC(1:end-ncol),ncol);                     %put col conductances on ncol th super and subdiagonal
V=diag(struct.CV(1:end-nrow*ncol),-nrow*ncol)+diag(struct.CV(1:end-nrow*ncol),nrow*ncol); %put layer conductances on nrow*ncol th super and subdiagonal
struct.H=H; struct.R=R; struct.C=C; struct.V=V;

B=H-R-C-V;                          %matrix used to compute the coefficent for each node =sum(adjacent conductances)-HCOF
struct.main_diag=sum(B);            %sum across rows of B to get central main diagonal terms of A  (can sum across cols too, doesnt matter)  

%% Construct  {A} %%
A=diag(struct.main_diag,0);
struct.A=A+R+C+V;

end

