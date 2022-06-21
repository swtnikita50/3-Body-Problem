function [position,isterminal,direction] = Events_poincareSection(t,x,G_var,section)

mu = G_var.Constants.mu;

isterminal = 1; 
switch section
    case 1
        position = x(2);
    case 2
        position = x(1)-(1-mu);
end

  if (x(1)<G_var.LagPts.L1(1)) || (x(1) < 1-mu &&  x(1) > G_var.LagPts.L1(1))
 direction = -1;
  elseif x(1)>G_var.LagPts.L2(1) || (x(1) > 1-mu &&  x(1) < G_var.LagPts.L2(1))
 direction = 1;
  elseif x(1)<G_var.LagPts.L3(1) || (x(1) < 0 &&  x(1) > G_var.LagPts.L3(1))
 direction = -1;
  end
 
 end