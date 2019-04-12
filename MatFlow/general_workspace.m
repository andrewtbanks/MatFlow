%% used to build matflow structure

ncol=11;
nrow=11;
nlay=1;
dim=ncol*nrow*nlay;
dr=11*ones(1,dim);
dc=11*ones(1,dim);
dv=11*ones(1,dim);
KR=1*ones(1,dim);
KC=1*ones(1,dim);
KV=1*ones(1,dim);
Ss=5E-6*ones(1,dim);
p=zeros(1,dim);
q=zeros(1,dim); 
q(61)=-0.2;

H0=10*ones(1,dim);
dt=0.1;

struct=MatFlow_format(nrow,ncol,nlay,dr,dc,dv,KR,KC,KV,Ss,p,q,dt,H0);
struct=MatFlow_v3(struct);
%%

 figure(1)
plot([1:1:dim],struct.H,'r-');
hold on
plot([1:1:dim],XNEW,'b--')
xlabel('cell #')
ylabel('head #')
legend('Matflow','Modflow')
