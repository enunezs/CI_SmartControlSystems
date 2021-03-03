
%% Configuracion inicial
start_Ki = 0.0723;
start_Kp = 0.0614;


divisions = 20;
range_start = 0;
range_end = 12;

%% Generacion de superficie de referencia
% CUIDADO: Tiempo de procesamiento largo
[x,y] = meshgrid(linspace(range_start,range_end,divisions),linspace(range_start,range_end,divisions));
for i = 1:size(x)
    for j = 1:size(y)
        z(i,j) =  CostFunction([x(i,j),y(i,j)]);
    end
end
writematrix(z,'Costs.xls')



%% Fmincon
cost_alias = @(x,y) CostFunction([x y]);

options = optimset('OutputFcn',@OutputFMincon,...
    'Display','off',...
    'MaxIter', 20,...
    'MaxFunEvals', 100,...
    'TolFun', 1e-3,...          
    'FinDiffType','central');   %Mayor resolucion

x0 = [start_Ki,start_Kp]; %Posicion de inicio

[x,fval,eflag,output] = fmincon(@CostFunction,x0,[],[],[],[],[0,0],[2,2],[],options);

Fcount = output.funcCount;
disp(['Number of function evaluations for fminsearch was ',num2str(Fcount)])
disp(['Number of solver iterations for fminsearch was ',num2str(output.iterations)])

%% Global Search
rng default 

%Configuracion de algoritmo global search
gs = GlobalSearch('NumTrialPoints', 50,...  %Num start points
    'NumStageOnePoints', 20,...             %Num stage one points
    'MaxTime',20*60,...                     %Stop after x seconds
    'FunctionTolerance',1e-4,...              %Tolerance
    'Display','iter',...
    'StartPointsToRun','bounds',...
    'PlotFcn',@OutputGlobalSearch);

%x0 = [start_Ki,start_Kp]; %Start Position
x0 = [1,1];


%Definimos problema a resolver
problem = createOptimProblem('fmincon',...  %solver
    'x0',x0,...                             %initial pos
    'objective',@CostFunction,...           %Set objective
    'lb',[0,0],'ub',[2,2], 'options', options)    %Set boundaries

%Ejecutar solucionador
x = run(gs,problem) 
    
