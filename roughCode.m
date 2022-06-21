% PLOT THE SYSTEM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PlotContourEquilPoints(G_var,G_varInt,'L1L2NsecPrim',system)
syms x y z;
r1 = sqrt((x-d1)^2+y^2+z^2);
r2 = sqrt((x-d2)^2+y^2+z^2);
jacobiConst = w^2*(x^2+y^2) + 2*G*m1/r1 + 2*G*m2/r2;
J = subs(jacobiConst,[x,y,z],[G_var.LagPts.L2,0]);
interval = [-2 2 -2 2]*lExt;
jacobiConst = subs(jacobiConst,z,0);
fimplicit(jacobiConst-J, interval,'DisplayName','Jacobi Constant','LineWidth',2);
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PLOT THE ORBIT
[~,x] = Integrator(G_var,fun_EOM,LyapOrb(i).IC(j,:),[0 LyapOrb(i).time(j,1)]);
x(:,1) = x(:,1)*l + d;
x(:,2) = x(:,2)*l;
x(:,3) = x(:,3)*l;
x(:,4) = x(:,4)*l*2*pi/T;
x(:,5) = x(:,5)*l*2*pi/T;
x(:,6) = x(:,6)*l*2*pi/T;
switch libNo
    case 1
        plot(x(:,1),x(:,2),'k', 'LineWidth',5)
    case 2
        plot(x(:,1),x(:,2),'r','LineWidth',5)
    case 3
        plot(x(:,1),x(:,2),'g','LineWidth',5)
end
hold on
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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

%         [~,xN] = Integrator(G_var,fun_EOM,XP,tspan,direction);
% 
%         % plot xP and xM
%         xN(:,1) = xN(:,1)*l+d;
%         xN(:,2) = xN(:,2)*l;
%         xN(:,3) = xN(:,3)*l;
%         xN(:,4) = xN(:,4)*l*2*pi/T;
%         xN(:,5) = xN(:,5)*l*2*pi/T;
%         xN(:,6) = xN(:,6)*l*2*pi/T;
%         plot(xN(:,1),xN(:,2),clr);hold on;grid on;