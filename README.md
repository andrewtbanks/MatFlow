# MatFlow
A simple finite difference implementation of the groundwater flow equation programmed in MATLAB.  


 Open and execute general_workspace.m or MatFlow_workspace.m to see some example models. 
 
 Format_MatFlow.m formats raw input which is readable by the main model script MatFlow_v3.m
 
 Cell_cond.m and Coeff_matrix.m format input data into matricies comprising the linear system {A}{h}={q}
 
 The linear system is passed to mgs.m which uses the modified grahm-schmidt method to solve.
 
 
 
 
 
 
