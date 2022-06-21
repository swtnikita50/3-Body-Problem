muExt = 0.0065;
muInt = 0.5;
ma = 4.59e11;
ms = muExt*ma;
mp = (1-muExt)*ma;
lExt = 1100;
lInt= 400;
G= 6.6743e-11;                 % Gravitational Constant

mps = muInt*(1-muExt)*ma;
mpp = (1-muInt)*(1-muExt)*ma;
%l = lInt/lExt;
Tint = 2*pi*sqrt(lInt^3/(G*mp));
wInt = 2*pi/Tint;
Text = 2*pi*sqrt(lExt^3/(G*ma));      % Angular velocity
wExt = 2*pi/Text;
%w_int = w_ext; %for planar and synchronous motion


dp = -muExt*lExt;
ds = (1-muExt)*lExt;
dpp = dp-muInt*lInt;
dps = dp+(1-muInt)*lInt;