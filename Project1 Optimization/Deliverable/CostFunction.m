%% Regresa costo asociado a las constantes [Kp,Ki]
%Toma array (Kp, Ki) como input
function C = CostFunction(pid)
%% Setup

%Abrir codigo Simulink 
EngineTimingModel
%Setup
simu_time = 10;
Kp = pid(1); 
Ki = pid(2);

%Comprobacion de errores
if Kp<0 || Ki<0
    %Arbitrariamente alto
    C = 50000;
    return    
end

%% Simulacion 

opt = simset('SrcWorkspace','Current'); 
%Asignar parametros de Simulink
set_param('EngineTimingModel/Controller/PID Controller','P',num2str(Kp));
set_param('EngineTimingModel/Controller/PID Controller','I',num2str(Ki));

%% Tomar valores de salida para el rango [inicio, final] y guardar
[tout,xout,yout] = sim('EngineTimingModel',[0 simu_time]);
time = tout;
ref_func = yout(:,3);   %Funcion de referencia en Simulink
response = yout(:,2);   %Respuesta obtenida
samples = length(time);
%samples = samples(1);

%% Calcular error
%Linear error
%C=sum(abs(response-ref_func))/samples;  

%Error Cuadratico
%C=sqrt( sum(abs(response-ref_func).^2) ) / samples;     

%Erro Cuadratico, Excluir rango 5.0-5.4
C= sqrt(sum(abs(response([1:50000 60000:end])-ref_func([1:50000 60000:end])).^2))/samples;  

%Mostrar datos en consola
disp(['cost of Kp = ',num2str(Kp), ',Ki = ', num2str(Ki), ' is ',num2str(C)])

end

