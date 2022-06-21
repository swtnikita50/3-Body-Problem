
for orbitNo = 1:10
    figure(1)
libPtNo = 1;
type = 'stable';
dir = 1;
switch orbitNo
    case 4
        dir = -1;
    case 8
        dir = -1;
end
[XNext] = LyapOrbitInvariantMfdsIC(G_varExt,LyapOrbExt,80,libPtNo,orbitNo,type,dir);
for i = 1:length(XNext(:,1,1))
    [t,x] = Integrator(G_varExt,G_varExt.IntFunc.EOM,XNext(i,:,1),[0 5*LyapOrbExt(libPtNo).time(orbitNo)],'backwardPoincareSection',2);
    plot(x(:,1),x(:,2),'-g'); hold on; grid on;
    y1s(i) = x(end,2);
    ydot1s(i) = x(end,5);
end


type = 'unstable';
dir = 1;
switch orbitNo
    case 7
        dir = -1;
    case 8
        dir = -1;
end
[XNext] = LyapOrbitInvariantMfdsIC(G_varExt,LyapOrbExt,80,libPtNo,orbitNo,type,dir);
for i = 1:length(XNext(:,1,1))
    [t,x] = Integrator(G_varExt,G_varExt.IntFunc.EOM,XNext(i,:,1),[0 5*LyapOrbExt(libPtNo).time(orbitNo)],'forwardPoincareSection',2);
    plot(x(:,1),x(:,2),'-r'); hold on; grid on;
    y1us(i) = x(end,2);
    ydot1us(i) = x(end,5);
end

libPtNo = 2;
type = 'unstable';
dir = -1;
[XNext] = LyapOrbitInvariantMfdsIC(G_varExt,LyapOrbExt,80,libPtNo,orbitNo,type,dir);
for i = 1:length(XNext(:,1,1))
    [t,x] = Integrator(G_varExt,G_varExt.IntFunc.EOM,XNext(i,:,1),[0 5*LyapOrbExt(libPtNo).time(orbitNo)],'forwardPoincareSection',2);
    plot(x(:,1),x(:,2),'-r'); hold on; grid on;
    y2us(i) = x(end,2);
    ydot2us(i) = x(end,5);
end

type = 'stable';
dir = -1;
switch orbitNo
    case 8
        dir = 1;
end
[XNext] = LyapOrbitInvariantMfdsIC(G_varExt,LyapOrbExt,80,libPtNo,orbitNo,type,dir);
for i = 1:length(XNext(:,1,1))
    [t,x] = Integrator(G_varExt,G_varExt.IntFunc.EOM,XNext(i,:,1),[0 5*LyapOrbExt(libPtNo).time(orbitNo)],'backwardPoincareSection',2);
    plot(x(:,1),x(:,2),'-g'); hold on; grid on;
    y2s(i) = x(end,2);
    ydot2s(i) = x(end,5);
end

figure(2);
plot(y1s,ydot1s,'-g','DisplayName','L1orbit_stablemfd');hold on;grid on;
plot(y2us,ydot2us,'--r','DisplayName','L2orbit_unstablemfd');
plot(y1us,ydot1us,'-r','DisplayName','L1orbit_unstablemfd');
plot(y2s,ydot2s,'--g','DisplayName','L2orbit_stablemfd');

end