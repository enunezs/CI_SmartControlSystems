%Ref val
start_Ki = 0.0723;
start_Kp = 0.0614;

start_Ki = 1.5;
start_Kp = 1.5;


%fmincon
%fminunc

%% FminSearch
%Open Simulink code
EngineTimingModel

%CostFunction([1 1])                

% Calls devec3 function with given parameters and function 'function'
%[x,f,nf] = devec3('DiffEvolCost',VTR,D,XVmin,XVmax,y,NP,itermax,F,CR,strategy,refresh);

cost_alias = @(x,y) CostFunction([x y]);
fun = @(x)(100*(x(2) - x(1)^2)^2 + (1 - x(1))^2);

%Pass the output function, which gets called after every iteration
options = optimset('Display','off'); 

x0 = [start_Ki,start_Kp]; %Start Position
%x0 = [.5,.5];
[x,fval,eflag,output] = fminsearch(@CostFunction,x0,options); %Pass function to minimize, start pos and simulation options
%title 'Engine! solution via fminsearch'
Fcount = output.funcCount;
disp(['Number of function evaluations for fminsearch was ',num2str(Fcount)])

%% Ref
% 
% options = optimset('OutputFcn',@bananaout,'Display','off'); 
% x0 = [-1.9,2]; 
% [x,fval,eflag,output] = fminsearch(fun,x0,options); 
% title 'Rosenbrock solution via fminsearch'
% 

%% Multistart

%% Global search

%% Simulated Annealing

%% PatternSearch

%% Particle Swarm

%% Genetic Algorithm