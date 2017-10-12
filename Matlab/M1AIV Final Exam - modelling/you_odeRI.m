function xdot= you_odeRI(t,x,pe) 

%x_names= {'N','E','A'}; -> x(1) is N, x(3) is E, x(3) is A 
%p_names= {'k','Nm','d','ke','de','va','da'}; -> p(1) is k, p(2) is Nm, etc
%m is pe(8);
%theta is pe(9);
%eta is pe(10);
xdot= zeros(size(x));
xdot(1)= pe(1)*x(1)*(1-x(1)/pe(2))-(pe(3)*x(2)*x(1));
xdot(2)=(0.2*pe(4)+ 5*pe(4)*((pe(8)).^pe(10)/(pe(9).^pe(10)+ pe(8).^pe(10) )))*x(3)-(pe(5)*x(2));
xdot(3)= ( pe(6)*0.2 + 5*pe(6) * ( (pe(8).^pe(10)) / (pe(9).^pe(10) + pe(8).^pe(10) )))*x(1) - (pe(7)*x(3)) ;
end
