function stop = OutputFunction(x,prop,state)
%Draw evolution of the algorithm

persistent ph
stop = false;

switch state
    case 'init'
        
        
        %Grafica base
        newplot
        divisions = 20;
        range_start = 0;
        range_end = 2;
        [xx,yy] = meshgrid(linspace(range_start,range_end,divisions),linspace(range_start,range_end,divisions));
        
        %Leer datos pre-generados 
        zz = readmatrix('Costs.xls');

        %Dibujar grafica
        % from 0 to 2, 20 divisions
        surf(xx(:,2:end),yy(:,2:end),zz(:,2:end));
        title('FMincon: Cost as function of Kp and Ki')
        xlabel('Kp')
        ylabel('Ki')
        zlabel('Cost')
        hold on;     
        drawnow

    case 'iter'
        %Graficar un punto
        %Obtener punto
        x1 = x(1);
        y1 = x(2);
        z1 = prop.fval;
        
        %Cambiar color en funcion de la iteracion
        color=hsv(10);
        ph = plot3(x1,y1,z1,'*','Color',color(mod(prop.iteration,10)+1,:),'MarkerSize',8);
        
        h = gca;
        h.SortMethod = 'childorder';
        drawnow;

        
    case 'done'
        %Finalizar, mostrar legendar y cerrar
        legend(ph,'Iterative steps','Location','east')
        hold off
end

end

