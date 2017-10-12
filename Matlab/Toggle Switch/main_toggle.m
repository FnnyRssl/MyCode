%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Toggle switch exercise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A=[m_L m_T p_L p_T];
%R1: emptyset -> m_L;  %R2: emptyset -> m_T;  
%R3: m_L -> emptyset;  %R4: m_T -> emptyset;  
%R5: m_L -> m_L + p_L; %R6: m_T -> m_T + p_T;  
%R7: p_L -> emptyset;  %R8: p_T -> emptyset;  
clear all;
close all;
% production rates (basal/induced) for LacI/TetR mRNA
kappa_L_m0= 0.0082;
kappa_T_m0= 0.0149;
kappa_L_m= 1;
kappa_T_m= 0.3865*2.2; %x2.2
% Hill function parameters for LacI/TetR regulation
theta_L= 600;
theta_T= 500;
eta_L= 4; 
eta_T= eta_L;
% dilution rates for LacI/TetR mRNA
gamma_L_m = 0.04;
gamma_T_m = gamma_L_m;
% production rates for LacI/TetR proteins from mRNA
kappa_L_p = 0.1;
kappa_T_p = kappa_L_p;
% dilution rates for LacI/TetR proteins
gamma_L_p = 0.002;
gamma_T_p = gamma_L_p;

pa(1)= kappa_L_m0;
pa(2)= kappa_T_m0;
pa(3)= kappa_L_m;
pa(4)= kappa_T_m;
pa(5)= theta_L;
pa(6)= theta_T;
pa(7)= eta_L;
pa(8)= eta_T;
pa(9)= gamma_L_m;
pa(10)= gamma_T_m;
pa(11)= kappa_L_p;
pa(12)= kappa_T_p;
pa(13)= gamma_L_p;
pa(14)= gamma_T_p;

figure(5); hold on;
plot_p(pa)

k(1)= NaN; %(pa(1) + pa(3)/(1 + (TetR_vector(j)/pa(6))^pa(8)));
k(2)= NaN; %(pa(2) + pa(4)/(1 + (LacI_vector(i)/pa(5))^pa(7)));
k(3)= pa(9);
k(4)= pa(10); %gamma_L_m;
k(5)= pa(11); %kappa_L_p; 
k(6)= pa(12); %kappa_T_p; 
k(7)= pa(13); %gamma_L_p; 
k(8)= pa(14); %gamma_T_p; 

c= [0 0 1 0 1 0 0 0;0 0 0 1 0 1 0 0;0 0 0 0 0 0 1 0;0 0 0 0 0 0 0 1];
p= [1 0 0 0 1 0 0 0;0 1 0 0 0 1 0 0;0 0 0 0 1 0 0 0;0 0 0 0 0 1 0 0]; 
tend= 10000;
Nreal= 6; %100;
figure(1); hold on; %time evolution
figure(2); hold on; %state space representations
X = get_equilibria(pa);
%A0= [0 0 0 0];
A0= X(3,:);
tspan=0:tend;
As_interp= zeros(Nreal, length(tspan), length(A0));
figure(1); hold on;
figure(2); hold on;
xlabel('LacI (copy numbers)')
ylabel('TetR (copy numbers)')
axis ([0 1500 0 1500]);

for r=1:Nreal
    disp(r);
    [t,As]= gillespiessa_toggle(k,c,p,A0,tend,pa(1:8));
    figure(1); stairs(t,As);
    figure(2); plot(As(:,3),As(:,4));
    for i=1:length(tspan)
        As_interp(r,i,:)= As(max(find(t<=tspan(i))),:);
    end
    %As_interp(r,:,:)= interp1(t,As,tspan,'nearest','extrap');
end
Amean= zeros(length(tspan), length(A0));
Astd= zeros(length(tspan), length(A0));
for j= 1:length(tspan)
    Amean(j,:)= mean(As_interp(:,j,:));
    Astd(j,:)= std(As_interp(:,j,:));
end
figure(1);
plot(tspan,Amean,'linewidth',3);
plot(tspan,Amean-Astd,'linewidth',3);
plot(tspan,Amean+Astd,'linewidth',3);
