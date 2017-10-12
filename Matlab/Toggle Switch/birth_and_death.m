function birth_and_death(mu, gamma, tend, A0)

tspan= 0:0.01:tend;
k= [mu, gamma]
c= [1 1];
p= [2 0];
figure(); hold on
for i=1:20
  [t,A] = gillespiessa(k,c,p,A0,tend);
  stairs(t,A);
end

tspan= 0:0.01:tend;
Adet= A0*exp((mu-gamma)*tspan);
plot(tspan,Adet,'linewidth',3);

end