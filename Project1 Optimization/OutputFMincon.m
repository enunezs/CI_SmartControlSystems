function stop = OutputFunction(x,prop,state)
%Draw evolution of the algorithm

persistent ph
stop = false;

switch state
    case 'init'
        
        
        %Base graph
        newplot
        divisions = 20;
        range_start = 0;
        range_end = 2;
        %Range
        [xx,yy] = meshgrid(linspace(range_start,range_end,divisions),linspace(range_start,range_end,divisions));
        zz = readmatrix('Costs.xls');
       
        % draw the surf plot
       
        % from 0 to 2, 20 divisions
        surf(xx(:,2:end),yy(:,2:end),zz(:,2:end));
        title('FMincon: Cost as function of Kp and Ki')
        xlabel('Kp')
        ylabel('Ki')
        zlabel('Cost')
        hold on;
     
        drawnow

    case 'iter'
        %plot a new point
        
        
        x1 = x(1);
        y1 = x(2);
        %z1 = CostFunction(x);
        z1 = prop.fval;
        
        color=hsv(10);
        
        ph = plot3(x1,y1,z1,'*','Color',color(mod(prop.iteration,10)+1,:),'MarkerSize',8);
        
        
        %plot3(x1,y1,z1,x_old,y_old,z_old);
        
        h = gca;
        h.SortMethod = 'childorder';
        drawnow;
        
        
        
    case 'done'
        legend(ph,'Iterative steps','Location','east')
        hold off
end

end

