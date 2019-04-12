function [ struct ] = ModFlow_Format(nrow,ncol,nlay,dr,dc,dv,KR,KC,KV,Ss,Q,dt,H0,filename)
%NAM FILE
struct.filename=filename;
%DIS FILE
struct.NLAY=nlay;
struct.NROW=nrow;
struct.NCOL=ncol;
struct.DIM=struct.NLAY*struct.NCOL*struct.NROW;

struct.NPER=1; %#of stress periods in simulation
struct.ITMUNI=0;%time unit (0=undefined)
struct.LENUNI=0;%length unit (0=undefined)

struct.DELR=dr;%single value not vectors
struct.DELC=dc; 
struct.TOP=dv;
struct.BOT=0.0;%bottom elevation

struct.PERLEN=dt;%stress period length
struct.NSTP=1;%# of timesteps in period

%BA6 FILE
struct.TSMULT=1;% multiplier for length of sucessive steps (keep 1.0 for constant step size.... probably doesnt matter if NSTP=1)
struct.X=H0;%ICS

%WEL FILE
struct.LAYER=1;
struct.ROW=ceil(NROW/2);
struct.COLUMN=ceil(NCOL/2);
struct.Q=Q;
struct.MXACTW=1;

%LPF FILE
struct.CHANI=1.0; %horizontal anisotropy for whole layer 
struct.VKA=KC/KV; %ratio of horizaontal to vertical hydraulic conductivity
struct.HK=KC; %hydraulic conductivity along rows
struct.Ss=Ss;%specific storage

%OC FILE (filename)
%PCG FILE

struct.MXITER=250;%maximum number of iterations to call for PCG solution routine
struct.HCLOSE=0.0001;%head change criterion for convergence in units of length (LENUNI)
struct.RCLOSE=0.006;%residual criterion for convergence


end

