%{
... Created on 10/3/2020 17:36
Plot wrapper
Choose any of the four
        % '2DContour'
        % '3DSurface'
        % 'EquilPointsNPrim'
        % 'L1L2NsecPrim'
...
%}
function Plotter(G_varExt,G_varInt)
fprintf('\n\n')
fprintf('----------------------\n')
fprintf('Plotting figures...\n')
fprintf('----------------------\n')

fprintf('\n')
fprintf('Plotting Contour,Surface and equilibrium points plots ...\n')
fprintf('\n')

figure()
PlotContourEquilPoints(G_varExt,G_varInt,'3DSurface','ext')
figure()
PlotContourEquilPoints(G_varExt,G_varInt,'2DContour','ext')
figure()
PlotContourEquilPoints(G_varExt,G_varInt,'EquilPointsNPrim','ext')


PlotLyapOrb(G_varExt,G_varInt,'ext') % seperate figures are defined inside
PlotLyapOrb(G_varInt,G_varInt,'int') % seperate figures are defined inside
 
figure()
fprintf('\n')
fprintf('Plotting manifolds at equilibrium points ...\n')
fprintf('\n')
%PlotEqPointManifold(G_varExt,'ext')
%PlotEqPointManifold(G_varInt,'int')




