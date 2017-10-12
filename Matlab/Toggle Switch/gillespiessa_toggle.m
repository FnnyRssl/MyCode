function [t,A] = gillespiessa_toggle(k,c,p,A0,tend,param)
t(1)= 0;
A(1,:)= A0;

while t<tend
  k(1)= (param(1) + param(3)/(1 + (A(end,4)/param(6))^param(8)));
  k(2)= (param(2) + param(4)/(1 + (A(end,3)/param(5))^param(7)));
  r1= rand();
  r2= rand();
  %compute all propensities and their sum a0
  a= zeros(size(k));
  for i=1:length(k) %reaction index
      j= find(c(:,i)); %moities index
      if length(j)==0 %zero-order reaction
          a(i)= k(i);
      elseif length(j)==1 %first-order reaction or homogenous second order
          if c(j,i)>1
              a(i)= k(i)*A(end,j)*(A(end,j)-1)/2;
          else
              a(i)= k(i)*A(end,j);
          end
      elseif length(j)==2 %second order reaction; we assume it is heterogeneous
          a(i)= k(i)*A(end,j(1))*A(end,j(2));
      end
  end
  a0= sum(a);
  tau= log(1/r1)/a0;
  %find I based on r2
  I= 1;
  while sum(a(1:I))< r2*a0
      I= I+1;
  end
  t(end+1)=t(end)+tau;
  A(end+1,:)= A(end,:)+p(:,I)'-c(:,I)';
end
t(end)= tend;
A(end,:)= A(end-1,:);
end