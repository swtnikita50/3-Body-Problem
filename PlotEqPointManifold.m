
%{
...
Created 10/3/2020 14:58

What it does ?
Function for plotting the manifolds at the periodic orbits(L1 and L2).

Inputs:
-------
      1)  G_var - GLobal Data
     
Outputs:
-------
     1) Plots the ZVC and marks the planets and equilibrium Points (or)
     2) Plots the manifolds at the L1 and L2 points 
     
Note: 
-----
At both the equilibrium points the colors of the manifolds are 

    Stable positive   - Green 
    Stable Negative   - Green dashed
    UnStable positive - Red 
    UnStable Negative - Red dashed

...
%}
function PlotEqPointManifold(G_var,system)
systemparameters;
switch system
    case 'ext'
        l = lExt;
        T = Text;
        d1 = dp;
        d2 = ds;
        w = wExt;
        m1 = mp;
        m2 = ms;
        d = 0;
    case 'int'
        l = lInt;
        T = Tint;
        d1 = dpp;
        d2 = dps;
        w = wInt;
        m1 = mpp;
        m2 = mps;
        d = dp;
end

mu = G_var.Constants.mu;
fun = G_var.IntFunc.EOM;


tspan = [0 10];
L1_xyPos = G_var.LagPts.L1';
L2_xyPos = G_var.LagPts.L2';
L1_StableEigVec = G_var.LagPts.SEigVec.L1;
L1_UStableEigVec = G_var.LagPts.USEigVec.L1;
L2_StableEigVec = G_var.LagPts.SEigVec.L2;
L2_UStableEigVec = G_var.LagPts.USEigVec.L2;

n = size(L1_StableEigVec,1);

if n < 6
    
    zero = zeros(2,1);
else
    
    zero = zeros(4,1);
end

% Eigen Vectors
L1StabPos   = [L1_xyPos;zero]  + 1e-6 *L1_StableEigVec;
L1StabNeg   = [L1_xyPos;zero]  - 1e-6 *L1_StableEigVec;
L1UstabPos  = [L1_xyPos;zero]  + 1e-6* L1_UStableEigVec;
L1UstabNeg  = [L1_xyPos;zero]   - 1e-6* L1_UStableEigVec;

L2StabPos   = [L2_xyPos;zero]  + 1e-6 *L2_StableEigVec;
L2StabNeg   = [L2_xyPos;zero]  - 1e-6 *L2_StableEigVec;
L2UstabPos  = [L2_xyPos;zero]  + 1e-6* L2_UStableEigVec;
L2UstabNeg  = [L2_xyPos;zero]  - 1e-6* L2_UStableEigVec;

Pert_EigVec = [L1StabPos L1StabNeg L2StabPos L2StabNeg L1UstabPos L1UstabNeg L2UstabPos L2UstabNeg];
figure()
for i = 1:4

[~,x] = Integrator(G_var,fun,Pert_EigVec(:,i),tspan,'backward');
x(:,1) = x(:,1)*l+d;
        x(:,2) = x(:,2)*l;
        x(:,3) = x(:,3)*l;
        x(:,4) = x(:,4)*l*2*pi/T;
        x(:,5) = x(:,5)*l*2*pi/T;
        x(:,6) = x(:,6)*l*2*pi/T;
    if i == 1 || i == 3
            plot(x(:,1),x(:,2),'g');hold on;
    elseif i == 2 || i == 4
            plot(x(:,1),x(:,2),'g--');hold on;
    end
hold on
grid on
end
%legend(x,'Stable Positive and Negative')

hold on
for i = 5:8
    
[~,x] = Integrator(G_var,fun,Pert_EigVec(:,i),tspan,'forward');
x(:,1) = x(:,1)*l+d;
        x(:,2) = x(:,2)*l;
        x(:,3) = x(:,3)*l;
        x(:,4) = x(:,4)*l*2*pi/T;
        x(:,5) = x(:,5)*l*2*pi/T;
        x(:,6) = x(:,6)*l*2*pi/T;
    if i == 5 || i == 7
        plot(x(:,1),x(:,2),'r');hold on;
    elseif i == 6 || i == 8
        plot(x(:,1),x(:,2),'r--');hold on;
    end
hold on
end
%legend(x,'Stable Positive and Negative')
%% Plot the  Contour

syms x y z;
r1 = sqrt((x-d1)^2+y^2+z^2);
r2 = sqrt((x-d2)^2+y^2+z^2);


jacobiConst = w^2*(x^2+y^2) + 2*G*m1/r1 + 2*G*m2/r2;
j = subs(jacobiConst,[x,y,z],[G_var.LagPts.L2*l,0]);
interval = [-2 2 -2 2]*lExt;
        jacobiConst = subs(jacobiConst,z,0);
        fimplicit(jacobiConst-j, interval,'DisplayName','Jacobi Constant','LineWidth',2);
        hold on

scatter([G_var.LagPts.L1(1),G_var.LagPts.L2(1),G_var.LagPts.L3(1),G_var.LagPts.L4(1),G_var.LagPts.L5(1)]*l+d*[1,1,1,1,1],...
[G_var.LagPts.L1(2),G_var.LagPts.L2(2),G_var.LagPts.L3(2),G_var.LagPts.L4(2),G_var.LagPts.L5(2)]*l,40,'*');
a = 400; b = 200;
        th = linspace(0,2*pi) ;
        xe = dp+a*cos(th) ;
        ye = 0+b*sin(th);
        plot(xe,ye,'r-', 'linewidth',4,'DisplayName','Primary Asteroid');

        scatter(d2,0,75,'o','MarkerFaceColor','blue')  

xlabel('\it{x-axis}')
ylabel('\it{y-axis}')
title('\it{Manifolds of Eqilibrium Points}')
        
%%  set the paper

set(gcf,'PaperPosition',[0 0 5 5]);
set(gcf,'PaperSize',[5 5])
%saveas(gcf, 'ManifoldsAtEqPoints', 'pdf');
