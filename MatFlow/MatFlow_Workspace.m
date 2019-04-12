%% used to build matflow structure
clc 
clear

ncol=5;
nrow=6;
nlay=1;
dim=ncol*nrow*nlay;
dr=11;
dc=11;
dv=11;
KR=1;
KC=1;
KV=1;
Ss=5E-6;

%compute center well position 
pos=ceil(ncol*nrow/2);
Q=-0.2;

%ICS
H0=10*ones(1,dim);
dt=0.1;

%Execute Matlfow
struct1=MatFlow_format(nrow,ncol,nlay,dr,dc,dv,KR,KC,KV,Ss,Q,pos,dt,H0);
struct1=MatFlow_v3(struct);
XNEW1=struct1.H;

%%EXECUTE Modflow
filename='test';
struct2=ModFlow_Format(nrow,ncol,nlay,dr,dc,dv,KR,KC,KV,Ss,Q,dt,H0,filename);

MFrun(struct2);
XNEW2=MFread(struct2);
