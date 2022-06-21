%{
...
Created on 28/02/2020  16:31 and modified on 9/3/2020

Plots the Lyapunov Orbits

...
%}
function PlotLyapOrb(G_var,G_varInt,system)
systemparameters;

switch system
    case 'ext'
        OrbPar = load('LyapOrbExtPar.mat');
        LyapOrbPar = OrbPar.LyapOrbExt;
        l = lExt;
        T = Text;
        d = 0;
    case 'int'
        OrbPar = load('LyapOrbIntPar.mat');
        LyapOrbPar = OrbPar.LyapOrbInt;
        l = lInt;
        T = Tint;
        d = dp;
end
%LyapOrbPar = OrbPar.LyapOrb;
fun_EOM = G_var.IntFunc.EOM;
NoofFam = size(LyapOrbPar(1).time,1);
%mu = G_var.Constants.mu;

%% ---------------------Lyap_L1 and Lyap_L2 Lyap_Lyap orbits-----------------------------
fprintf('\n')
fprintf('Plotting the Lyapunov orbits of L1 and L2 ...\n')
fprintf('\n')
figure()
for Loc  = 1:size(LyapOrbPar,2)
for i = 1: 2: NoofFam
    [~,x] = Integrator(G_var,fun_EOM,LyapOrbPar(Loc).IC(i,:),[0 LyapOrbPar(Loc).time(i,1)]);
        x(:,1) = x(:,1)*l + d;
        x(:,2) = x(:,2)*l;
        x(:,3) = x(:,3)*l;
        x(:,4) = x(:,4)*l*2*pi/T;
        x(:,5) = x(:,5)*l*2*pi/T;
        x(:,6) = x(:,6)*l*2*pi/T;
        switch Loc 
            case 1
                plot(x(:,1),x(:,2),'k')
            case 2 
                plot(x(:,1),x(:,2),'r')
            case 3
                plot(x(:,1),x(:,2),'g')
        end
    hold on
    grid on
end
    hold on
end
    PlotContourEquilPoints(G_var,G_varInt,'L1L2NsecPrim',system)

    xlabel('\it{x-axis}')
    ylabel('\it{y-axis}')
    title('\it{Lyapunov orbits of L_{1} and L_{2}}')
    
    set(gcf,'PaperPosition',[0 0 5 5]);
    set(gcf,'PaperSize',[5 5])

%% ---------------------Lyap_L1 Lyap_Lyap orbits-----------------------------
% figure()
% for i = 1: 2: NoofFam
%     [~,x] = Integrator(G_var,fun_EOM,LyapOrbPar(1).IC(i,:),[0 LyapOrbPar(1).time(i,1)]);
%         x(:,1) = x(:,1)*l + d;
%         x(:,2) = x(:,2)*l;
%         x(:,3) = x(:,3)*l;
%         x(:,4) = x(:,4)*l*2*pi/T;
%         x(:,5) = x(:,5)*l*2*pi/T;
%         x(:,6) = x(:,6)*l*2*pi/T;
%     plot(x(:,1),x(:,2),'k')
%     hold on
%    
% end
%  grid on
%     PlotContourEquilPoints(G_var,G_varInt,'L1L2NsecPrim',system)
% 
%     xlabel('\it{x-axis}')
%     ylabel('\it{y-axis}')
%     title('\it{Lyapunov Orbits of L_1}')
%     
%     set(gcf,'PaperPosition',[0 0 5 5]);
%     set(gcf,'PaperSize',[5 5])
% 
% %% ---------------------Lyap_L2 Lyap_Lyap orbits-----------------------------
% figure()
% for i = 1: 2: NoofFam
%     [~,x] = Integrator(G_var,fun_EOM,LyapOrbPar(2).IC(i,:),[0 LyapOrbPar(2).time(i,1)]);
%         x(:,1) = x(:,1)*l + d;
%         x(:,2) = x(:,2)*l;
%         x(:,3) = x(:,3)*l;
%         x(:,4) = x(:,4)*l*2*pi/T;
%         x(:,5) = x(:,5)*l*2*pi/T;
%         x(:,6) = x(:,6)*l*2*pi/T;
%     plot(x(:,1),x(:,2),'k')
%     hold on
% end
%  grid on
%     PlotContourEquilPoints(G_var,G_varInt,'L1L2NsecPrim',system)
% 
%     xlabel('\it{x-axis}')
%     ylabel('\it{y-axis}')
%     title('\it{Lyapunov Orbits of L_2}')
%     
%     set(gcf,'PaperPosition',[0 0 5 5]);
%     set(gcf,'PaperSize',[5 5])
 
 