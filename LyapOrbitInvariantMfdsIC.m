
%{
...
Created on  05/6/2022 17:23

This File plots the invariant manifolds along the lyapunov orbit.

Inputs
------
1) G_var - Global Data
2) LyapOrb - Lyapunov orbit parameters we get from LyapOrbitParameters.m
3) n - The number of nodes along the lyapunov orbit to plot manifolds
4) system - defines external or internal system
5) libNo - Number of liberation point used
6) orbitNo - number of orbit used from the family

Outputs
--------


Dependencies
------------
1) StateTransAndX
2) EOM
3) VarEq
4) Integrator(fun,x0,[0 tspan]);

...
%}

function [Xn] = LyapOrbitInvariantMfdsIC(G_var,LyapOrb,n,libPtNo, orbitNo,type, dir)
systemparameters;


funVarEq = G_var.IntFunc.VarEqAndSTMdot;
epsilon = 10^-6;

switch type 
    case 'stable'
        eigVec = LyapOrb(libPtNo).Eigens(orbitNo).S_EigVec;
        eigVal = LyapOrb(libPtNo).Eigens(orbitNo).S_EigVal;
    case 'unstable'
        eigVec = LyapOrb(libPtNo).Eigens(orbitNo).US_EigVec;
        eigVal = LyapOrb(libPtNo).Eigens(orbitNo).US_EigVal;
end
tf = LyapOrb(libPtNo).time(orbitNo);
X0 = LyapOrb(libPtNo).IC(orbitNo,:)';


k = 1;
    %if isreal(eigVal)
        Y0int = eigVec(:,k);
    %else
        %break;
    %end

    [~,PHItf,~,~,PHI] = StateTransAndX(G_var,X0,funVarEq,tf);
    i = 1;
    for m = 1:floor(length(PHI(:,1))/(n-1)):length(PHI(:,1))
        phi = reshape(PHI(m,1:36),6,6);
        X0 = reshape(PHI(m,37:42),6,1);
        Y0 = phi*Y0int;
        %Normalize Ys0 to 1
        normY0 = norm(Y0(1:3));
        Y0 = Y0/normY0;
        XN(i,:) = X0 + dir*epsilon*Y0;
        i = i+1;
    end
    Xn(:,:,k) = XN(:,:);
end


                






