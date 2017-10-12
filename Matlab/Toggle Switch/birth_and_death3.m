function birth_and_death(mu, gamma, tend, A0)

tspan= 0:0.01:tend;
k= [mu, gamma]
c= [1 1];
p= [2 0];
figure(); hold on
for i=1:20
  [t,A] = gillespiessa(k,c,p,A0,tend);
  stairs(t,A);
  for j=1:length(tspan)
        A_interp(i,j,:)= A(max(find(t<=tspan(j))),:);
  end
end

tspan= 0:0.01:tend;
Adet= A0*exp((mu-gamma)*tspan);
plot(tspan,Adet,'linewidth',3);

Amean= zeros(length(tspan), length(A0));
Astd= zeros(length(tspan), length(A0));
for j= 1:length(tspan)
    Amean(j,:)= mean(A_interp(:,j,:));
    Astd(j,:)= std(A_interp(:,j,:));
end
figure(1);
plot(tspan,Amean,'linewidth',3);
plot(tspan,Amean-Astd,'linewidth',3);
plot(tspan,Amean+Astd,'linewidth',3);

end