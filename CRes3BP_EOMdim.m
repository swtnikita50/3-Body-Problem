function X_Dot = CRes3BP_EOMdim(t,X,mu)

syms x y z
systemparameters;

r1 = sqrt((x-dp)^2+y^2+z^2);
r2 = sqrt((x-ds)^2+y^2+z^2);
w=wExt;
U = w^2*(x^2+y^2)/2 + G*mp/r1 + G*ms/r2;
gradU = gradient(U);

if length(X)>4
type = 'ThreeDim';
else
    type = 'Planar';
end


switch type 
    case 'Planar'
        % Unpack the state variables

Ux = subs(gradU(1,1),[x,y,z], [X(1),X(2),0]);
Uy = subs(gradU(2,1),[x,y,z], [X(1),X(2),0]);

xDot  = X(3);
yDot  = X(4);

xDDot = 2*yDot + Ux;
yDDot = -2*xDot + Uy;


X_Dot = [xDot;yDot;xDDot;yDDot];

%============================================================================
    case 'ThreeDim'
% Unpack the state variables


% Partial Derivative of the Pseudo Potential Function
Ux = subs(gradU(1,1),[x,y,z], [X(1),X(2),X(3)]);
Uy = subs(gradU(2,1),[x,y,z], [X(1),X(2),X(3)]);
Uz = subs(gradU(3,1),[x,y,z], [X(1),X(2),X(3)]);


xDot  = X(4);
yDot  = X(5);
zDot  = X(6);
xDDot = 2*yDot + Ux;
yDDot = -2*xDot + Uy;
zDDot = Uz;



X_Dot = [xDot;yDot;zDot;xDDot;yDDot;zDDot];


end