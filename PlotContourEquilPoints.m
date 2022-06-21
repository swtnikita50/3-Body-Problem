function PlotContourEquilPoints(G_var,G_varInt,type,system)
%{
...
Created on 21/2/2020 17:50

What it does ?
Function for plotting other general system points of interest.

Inputs:
-------
      1)  G_var - GLobal Data
      2)  type - Choose between 2D and 3D isosurface

and gives
Outputs:
-------
     1) Plots the ZVC and marks the planets and equilibrium Points (or)
     2) Plots 3D isosurface 
     3) Only euilibrium points and primaries
     4) Plots L1 L2 and secondary (to view with lyapunov orbits
depending on the 'type'


 ------------------------------------------------------------------------
...
%}
systemparameters;

%G_var = GlobalData;
LagPts = G_var.LagPts;
LagPts.L1 = LagPts.L1*lExt;LagPts.L2 = LagPts.L2*lExt;LagPts.L3 = LagPts.L3*lExt;
LagPts.L4 = LagPts.L4*lExt;LagPts.L5 = LagPts.L5*lExt;
LagPtsInt = G_varInt.LagPts;
LagPtsInt.L1 = LagPtsInt.L1*lInt + [dp,0];LagPtsInt.L2 = LagPtsInt.L2*lInt + [dp,0];LagPtsInt.L3 = LagPtsInt.L3*lInt+[dp,0];
LagPtsInt.L4 = LagPtsInt.L4*lInt+ [dp,0];LagPtsInt.L5 = LagPtsInt.L5*lInt+ [dp,0];

%ReqEnergy = G_var.Constants.ReqEnergy;

switch system
    case 'ext'
        d1 = dp;
        d2 = ds;
        w = wExt;
        m1 = mp;
        m2 = ms;
    case 'int'
        d1 = dpp;
        d2 = dps;
        w = wInt;
        m1 = mpp;
        m2 = mps;
end

syms x y z;
r1 = sqrt((x-d1)^2+y^2+z^2);
r2 = sqrt((x-d2)^2+y^2+z^2);


jacobiConst = w^2*(x^2+y^2) + 2*G*m1/r1 + 2*G*m2/r2;
j = subs(jacobiConst,[x,y,z],[LagPts.L2,0]);

ast1Surface = (x-dp)^2/400^2 + y^2/200^2 + z^2/200^2 -1;
ast2Surface = (x-ds)^2 + y^2 +z^2 - 75^2;

switch type
    case '2DContour'
        
        interval = [-2 2 -2 2]*lExt;
        jacobiConst = subs(jacobiConst,z,0);
        
        fimplicit(jacobiConst-j, interval,'DisplayName','Jacobi Constant','LineWidth',2);
        hold on

        scatter([LagPts.L1(1),LagPts.L2(1),LagPts.L3(1),LagPts.L4(1),LagPts.L5(1)],...
            [LagPts.L1(2),LagPts.L2(2),LagPts.L3(2),LagPts.L4(2),LagPts.L5(2)],40,'*');
        grid on
        ast1Surface = subs(ast1Surface,z,0);
        ast2Surface = subs(ast2Surface,z,0);
        fimplicit(ast1Surface, interval,'-r','LineWidth',2,'DisplayName','PrimaryAsteroid');
        fimplicit(ast2Surface, interval,'-b','LineWidth',2,'DisplayName','SecondaryAsteroid');
        xlabel('\it{x-axis}')
        ylabel('\it{y-axis}')
        title(['\it{Contour Plot for Energy: }',num2str(double(j))])
        set(gcf,'PaperPosition',[0 0 5 5]);
        set(gcf,'PaperSize',[5 5])
        %saveas(gcf, 'ContourPlot', 'pdf');


    case '3DSurface'
        interval = [-2 2 -2 2 -2 2]*lExt;

        fimplicit3(jacobiConst-j, interval,'EdgeColor','none','FaceAlpha',.5,'DisplayName','Jacobi Constant','FaceColor','g');
        hold on

        hold on
        scatter([LagPts.L1(1),LagPts.L2(1),LagPts.L3(1),LagPts.L4(1),LagPts.L5(1)],...
            [LagPts.L1(2),LagPts.L2(2),LagPts.L3(2),LagPts.L4(2),LagPts.L5(2)],40,'*');
        grid on
        fimplicit3(ast1Surface, interval,'-r','LineWidth',2,'DisplayName','PrimaryAsteroid');
        fimplicit3(ast2Surface, interval,'-b','LineWidth',2,'DisplayName','SecondaryAsteroid');
        xlabel('\it{x}')
        ylabel('\it{y}')



    case 'EquilPointsNPrim'

        interval = [-2 2 -2 2]*lExt;
        hold on
        grid on
        scatter([LagPts.L1(1),LagPts.L2(1),LagPts.L3(1),LagPts.L4(1),LagPts.L5(1)],...
            [LagPts.L1(2),LagPts.L2(2),LagPts.L3(2),LagPts.L4(2),LagPts.L5(2)],55,'*');
        scatter([LagPtsInt.L1(1),LagPtsInt.L2(1),LagPtsInt.L3(1),LagPtsInt.L4(1),LagPtsInt.L5(1)],...
            [LagPtsInt.L1(2),LagPtsInt.L2(2),LagPtsInt.L3(2),LagPtsInt.L4(2),LagPtsInt.L5(2)],55,'*');


        ast1Surface = subs(ast1Surface,z,0);
        ast2Surface = subs(ast2Surface,z,0);
        fimplicit(ast1Surface, interval,'-r','LineWidth',2,'DisplayName','PrimaryAsteroid');
        fimplicit(ast2Surface, interval,'-b','LineWidth',2,'DisplayName','SecondaryAsteroid');
        scatter(dpp,0,75,'o','MarkerFaceColor','k')
        scatter(dps,0,75,'o','MarkerFaceColor','k')
        line([LagPts.L3(1),LagPts.L2(1)],[0,0],'Color','black','LineWidth',0.75)
        line([LagPtsInt.L3(1),LagPtsInt.L2(1)],[0,0],'Color','red','LineWidth',0.75)
        %line([0,0],[-1,1],'Color','black','LineWidth',0.75)

        line([d1,LagPts.L4(1)],[0,LagPts.L4(2)],'Color','black','LineWidth',2)
        line([d2,LagPts.L4(1)],[0,LagPts.L4(2)],'Color','black','LineWidth',2)
        line([d1,LagPts.L5(1)],[0,LagPts.L5(2)],'Color','black','LineWidth',2)
        line([d2,LagPts.L5(1)],[0,LagPts.L5(2)],'Color','black','LineWidth',2)

        line([dpp,LagPtsInt.L4(1)],[0,LagPtsInt.L4(2)],'Color','red','LineWidth',2)
        line([dps,LagPtsInt.L4(1)],[0,LagPtsInt.L4(2)],'Color','red','LineWidth',2)
        line([dpp,LagPtsInt.L5(1)],[0,LagPtsInt.L5(2)],'Color','red','LineWidth',2)
        line([dps,LagPtsInt.L5(1)],[0,LagPtsInt.L5(2)],'Color','red','LineWidth',2)
        xlabel('\it{x-axis}')
        ylabel('\it{y-axis}')
        title('Eqilibrium Points and Primaries')

        set(gcf,'PaperPosition',[0 0 5 5]);
        set(gcf,'PaperSize',[5 5])
        %saveas(gcf, 'PrimAndEqPts', 'pdf');

    case 'L1L2NsecPrim'


        hold on
        grid on
        scatter([LagPts.L1(1),LagPts.L2(1),LagPts.L3(1)],...
            [LagPts.L1(2),LagPts.L2(2),LagPts.L3(2)],55,'*');
        scatter([LagPtsInt.L1(1),LagPtsInt.L2(1),LagPtsInt.L3(1)],...
            [LagPtsInt.L1(2),LagPtsInt.L2(2),LagPtsInt.L3(2)],55,'*');

        SOE;
        F = subs(F,z,0);
        interval = [-2 2 -2 2]*lExt;
        fimplicit(F-0.05, interval,'DisplayName','k=0.05','LineWidth',2);hold on;grid on;


        ast1Surface = subs(ast1Surface,z,0);
        ast2Surface = subs(ast2Surface,z,0);
        fimplicit(ast1Surface, interval,'-r','LineWidth',2,'DisplayName','PrimaryAsteroid');
        fimplicit(ast2Surface, interval,'-b','LineWidth',2,'DisplayName','SecondaryAsteroid');
        scatter(dpp,0,75,'o','MarkerFaceColor','k')
        scatter(dps,0,75,'o','MarkerFaceColor','k')


        xlabel('\it{x-axis}')
        ylabel('\it{y-axis}')

end