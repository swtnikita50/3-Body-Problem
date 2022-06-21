function [position,isterminal,direction] = EventsSOE(t,X,G_var)


mu = G_var.Constants.mu;
l = G_var.Constants.l;
SOE;
F = double(subs(F,[x,y,z],[X(1),X(2),X(3)]*l));
soe_val = 0.05;

if F> soe_val
    position = 0;
else 
    position = 1;
end
isterminal = 1;

  if (X(1)<G_var.LagPts.L1(1)) || (X(1) < 1-mu &&  X(1) > G_var.LagPts.L1(1))
 direction = -1;
  elseif X(1)>G_var.LagPts.L2(1) || (X(1) > 1-mu &&  X(1) < G_var.LagPts.L2(1))
 direction = 1;
  elseif X(1)<G_var.LagPts.L3(1) || (X(1) < 0 &&  X(1) > G_var.LagPts.L3(1))
 direction = -1;
  end


   
 
 end