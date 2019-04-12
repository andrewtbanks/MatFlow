function [struct] = cell_cond(struct)

%% cell_cond for MatFlow v3 %% 
% updates model structure with conductance terms %
%  - structure must already contain discretization information %

%% call discretization variables %%

ncol=struct.ncol;
nrow=struct.nrow;
nlay=struct.nlay;
dim=struct.dim;

KR=struct.KR;
KC=struct.KC;
KV=struct.KV;

dv=struct.dv;
dr=struct.dr;
dc=struct.dc;


refgrid=struct.refgrid;

%% use loop to compute cell centered conductances %% 

colcnt=1;
rowcnt=1;
laycnt=1;

for k=1:nlay %loop through all layers k=1,...,nlay
%% compute cell centered row conductences CR (left to right of each layer) %%   
    
  for i=1:nrow
        for j=2:ncol 
          row_ref=[refgrid(i,j-1,k),refgrid(i,j,k)];                             %call indicies of each row pair using the reference grid 
          dr_c(rowcnt)=0.5*(dr(row_ref(1))+dr(row_ref(2)));                     %compute cell centered flow path between each pair
          KR_c(rowcnt)=0.5*(KR(row_ref(1))+KR(row_ref(2)));                     %compute cell centered hydraulic conductivity between each pair
          CR(rowcnt)=KR_c(rowcnt)*dc(row_ref(1))*dv(row_ref(1))/dr_c(rowcnt);   %compute cell centered row conductance between each pair
          rowcnt=rowcnt+1;                                                      %shift rowcnt to next reference position
        end
     rowcnt=rowcnt+1;                                                           %shift rowcnt 1 extra position at the end (ncol) of each row  
  end
    
%% compute cell centered column conductences CC (top to bottom of each layer) %% 

    for i=2:nrow
        for j=1:ncol
          col_ref=[refgrid(i-1,j,k),refgrid(i,j,k)];                            %calls indicies of each column pair using the reference grid 
          dc_c(colcnt)=0.5*(dc(col_ref(1))+dc(col_ref(2)));                     %compute cell centered flow path between each pair
          KC_c(colcnt)=0.5*(KC(col_ref(1))+KC(col_ref(2)));                     %compute cell centered hydraulic conductivity between each pair
          CC(colcnt)=KC_c(colcnt)*dr(col_ref(1))*dv(col_ref(1))/dc_c(colcnt);   %compute cell centered col conductance between each pair
          colcnt=colcnt+1;                                                      %shift colcnt to next reference position
        end
    end
    
     colcnt=colcnt+ncol;                                                        %shift colcnt ncol extra positions at the end (nrow) of each column 

%% compute cell centered layer conductences CV (top layer to bottom layer) %% 

  if k~=nlay && nlay~=1 % because no layer conductance terms for the last (or only) layer 
    for i=1:nrow
        for j=1:ncol
          lay_ref=[refgrid(i,j,k),refgrid(i,j,k+1)] ;                            %call indicies of each layer pair using the reference grid 
          dv_c(laycnt)=0.5*(dv(lay_ref(1))+dv(lay_ref(2)));                     %compute cell centered flow path lengths between each pair
          KV_c(laycnt)=0.5*(KV(lay_ref(1))+KV(lay_ref(2)));                     %compute cell centered hydraulic conductivity between each pair
          CV(laycnt)=KV_c(laycnt)*dr(lay_ref(1))*dv(lay_ref(1))/dv_c(laycnt);   %compute cell centered col conductance between each pair
          laycnt=laycnt+1;                                                      %shift laycnt to next reference position
        end
    end
    struct.dv_c=dv_c;
    struct.KV_c=KV_c;
  else CV=zeros(1,dim-ncol*nrow); %replace with zeros if there is only one layer
  end
  
end

%% (preserve dimension due to the loop above) 
CC(end+ncol)=0;     %place zero for last ncol cells of last layer 
CR(end+1)=0;        %place zero for last cell of last layer 
CV(end+ncol*nrow)=0; %place zero for all cells of last layer 

%% update model structure %%
struct.KC_c=KC_c;
struct.KR_c=KR_c;

struct.dr_c=dr_c;
struct.dc_c=dc_c;

struct.CC=CC;
struct.CR=CR;
struct.CV=CV;

end


            
        