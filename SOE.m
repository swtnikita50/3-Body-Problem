syms x y z
systemparameters;

r1int = sqrt((x-dpp)^2+y^2+z^2);
r2int = sqrt((x-dps)^2+y^2+z^2);
r1ext = sqrt((x-dp)^2+y^2+z^2);
rint = r1ext;
r2ext = sqrt((x-ds)^2+y^2+z^2);
rext = sqrt(x^2+y^2+z^2);

a_int = [wInt^2*x - G*(mpp*(x-dpp)/r1int^3 + mps*(x-dps)/r2int^3);...
    wInt^2*y - G*y*(mpp/r1int^3+mps/r2int^3);...
    - G*z*(mpp/r1int^3+mps/r2int^3)];

a_2b = [(wInt^2 - G*mp/rint^3)*x;...
    (wInt^2 - G*mp/rint^3)*y;
    - G*mp/rint^3*z];

F = norm(a_int-a_2b)/norm(a_int);