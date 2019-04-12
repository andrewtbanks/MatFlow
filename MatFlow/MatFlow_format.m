 function [struct] = MatFlow_format(nrow,ncol,nlay,dr,dc,dv,KR,KC,KV,Ss,Q,pos,dt,H0)


%% format into structure 
dim=nrow*ncol*nlay;

struct.nrow=nrow;
struct.ncol=ncol;
struct.nlay=nlay;


struct.dim=dim; %compute overall dimension of problem


struct.dr=dr*ones(1,dim);
struct.dc=dc*ones(1,dim);
struct.dv=dv*ones(1,dim);

struct.Ss=Ss*ones(1,dim);
struct.q=zeros(1,dim);
struct.q(pos)=Q;%set  discharge rate
struct.p=zeros(1,dim);


struct.KR=KR*ones(1,dim);
struct.KC=KC*ones(1,dim);
struct.KV=KV*ones(1,dim);

 struct.dt=dt;
 struct.H0=H0;
%% Build Numbered Reference Grid  %%
num=1;
for k=1:struct.nlay 
    for i=1:struct.nrow
        for j=1:struct.ncol
         refgrid(i,j,k)=num; %numbered 1,2,..,dim starting at top left cell of layer 1
         num=num+1;
       end
   end
end
struct.refgrid=refgrid;


%%
struct = cell_cond(struct);



 end
