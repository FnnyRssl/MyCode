%% REFERENCIAL PARAMETERS

close all
clear all 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Analysis of the original model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_names= {'N','E','A'}; % N is in CFU
p_names= {'k','Nm','d','ke','de','va','da'};

%define reference parameter values (from paper)
p_ref([3 4 5 6])= [4*10^(-3) 5 2 4.8*10^(-7)]; %set values for d, ke, de, and va
p_ref([1 2 7])= [0.97 1.24*10^(9) 0.639];% set values for k, Nm and da at pH 7

%define initial condifions and simulation time (somewhat arbitrary)
x0= [100 0 0];
tspan= [0:1:60];

%In order to avoid doing always the same computations, you can set several Q to 0...
Q1=1; Q2=1; Q3=1; Q4=1; Q5=1; Q6_7=1; Q8=1; Q9=1; Q10=1;


% Computes ON and OFF behaviors of engineered system; plot on same figure

%% QUESTION 1

if Q1
    display('--------------Question 1--------------');
    %set parameters p for the ON system and do numerical simulation
    p= p_ref;
    [t x_on]= ode15s(@you_ode,tspan, x0, [], p);
    %set parameters p for the OFF system and do numerical simulation
    p= p_ref; p(4)=0; p(5)=0; %define p
    [t x_off]= ode15s(@you_ode,tspan, x0, [], p);
    
    figure(1)
    subplot(2,1,1); plot(t,x_on(:,1)/p_ref(2)); legend('N/Nm'); hold on 
    subplot(2,1,2); plot(t,x_on(:,2:3)); legend('E','A'); hold on
    subplot(2,1,1); plot(t,x_off(:,1)/p_ref(2),'--'); legend('N/Nm'); xlabel('Time in Hours'); ylabel('Ratio'); title({'Evolution of the N/Nm ratio for the ON and OFF circuits';'at PH = 7.0'});
    subplot(2,1,2); plot(t,x_off(:,2:3),'--'); legend('Eon','Aon','Eoff','Aoff');xlabel('Time in Hours'); ylabel({'Cell density : CFU/mL';'Specie concentration : nM'}); title({'Evolution of cell density  and specie concentration for the ON and OFF circuits';'at PH = 7.0'})
end

%% QUESTION 2

% Compute cell density of engineered system at pH6.2 and pH7.8 and the corresponding fold change

p_pH62= [0.885 1.25*10^(9) 0.274];% stores values of k, Nm and da at pH 6.2   
p_pH78= [0.936 1.20*10^(9) 1.19];% same at pH 7.8   

if Q2
    display('--------------Question 2--------------');
    %compute cell density at steady state for pH6.2; stored in Nmin
    p=p_ref; p(1)=p_pH62(1); p(2)=p_pH62(2); p(7)=p_pH62(3); %define p
    [t x]= ode15s(@you_ode,tspan, x0, [], p);
    Nmin= x(:,1); %define Nmin using x
    
    %compute cell density at steady state for pH7.8; stored in Nmax
    p=p_ref; p(1)=p_pH78(1); p(2)=p_pH78(2); p(7)=p_pH78(3);  %define p
    [t x]= ode15s(@you_ode,tspan, x0, [], p);
    Nmax= x(:,1);
   
    %plotting
    hold on
    plot(Nmin)
    plot(Nmax); legend('Nmin : pH=6.2','Nmax : pH=7.8'); title({'Cell growth for ON circuit';'at pH=6.2 and pH=7.8'}); xlabel('Time in Hours'); ylabel('Cell density : CFU/mL');
%     
    %define and display the fold change associated to pH variations
    fold_change_pH= Nmax(end)/Nmin(end) ;% define fold_change_pH as a function of Nmin and Nmax;
    display(['fold change; ' num2str(fold_change_pH)]); % just for nice display; "num to string" converts numbers to strings of characters
end

%% QUESTION 3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Analysis of extended  models
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%extended parameter set
%all parameters unchanged, excepted m, theta, and eta  

%pe_names= {'k','Nm','d','ke','de','va','da','m','theta','eta'};

if Q3
    display('--------------Question 3: see text--------------');
end


if Q4
    display('--------------Question 4: see you_ode, you_odeR, you_odeI, and you_odeRI functions--------------');
end

%% QUESTION 5

%pe stands for parameters of extended system
pe_ref(1:7)= p_ref;
pe_ref([8 9 10])= [1 1 2.1]; %m=1, theta=1, and eta= 2.1

if Q5
    display('--------------Question 5--------------');
        
    figure(2)
    pe= pe_ref; %define pe
    [t x]= ode15s(@you_odeR,tspan, x0, [], pe); % compute behavior of circuit R
    subplot(2,1,1); plot(t,x(:,1)/pe_ref(2)); legend('N/Nm');xlabel('Time in Hours'); ylabel('Ratio'); title({'Evolution of the N/Nm ratio';'with Promoter R'});
    subplot(2,1,2); plot(t,x(:,2:3)); legend('E','A'); xlabel('Time in Hours'); ylabel('Specie concentration : nM'); title('Evolution of cell density for promoter R');
    ss= x(end,:); % store steady state values for N, E, and A
    display(['ss for circuit R: ' num2str(ss)]);
    
    figure(3)
    pe= pe_ref;
    [t x]= ode15s(@you_odeI,tspan, x0, [], pe); % compute behavior of circuit I
    subplot(2,1,1); plot(t,x(:,1)/pe_ref(2)); legend('N/Nm');xlabel('Time in Hours'); ylabel('Ratio'); title({'Evolution of the N/Nm ratio';'with Promoter I'});
    subplot(2,1,2); plot(t,x(:,2:3)); legend('E','A');xlabel('Time in Hours'); ylabel('Specie concentration : nM'); title('Evolution of cell density for promoter I');
    ss= x(end,:);
    display(['ss for circuit I: ' num2str(ss)]);
    
    figure(4)
    pe= pe_ref;
    [t x]= ode15s(@you_odeRI,tspan, x0, [], pe); % compute behavior of circuit RI
    subplot(2,1,1); plot(t,x(:,1)/pe_ref(2)); legend('N/Nm');xlabel('Time in Hours'); ylabel('Ratio'); title({'Evolution of the N/Nm ratio';'with Promoter RI'});
    subplot(2,1,2); plot(t,x(:,2:3)); legend('E','A');xlabel('Time in Hours'); ylabel('Specie concentration : nM'); title('Evolution of cell density for promoter RI');
    ss= x(end,:);
    display(['ss for circuit RI: ' num2str(ss)]);
end

%% QUESTIONS 6 & 7

%pe stands for parameters of extended system
pe_ref(1:7)= p_ref;
pe_ref([8 9 10])= [1 1 2.1]; %m=1, theta=1, and eta= 2.1

m= [0 0.1 0.2 0.4 0.6 0.8 1 1.5 2 3];
%m= [0 1 3]; %for debugging purpose, you can do computations with this m vector. computations are fastest!
if Q6_7
    display('--------------Question 6 and 7--------------');
        
    %compute nominal I/O behavior for the 3 models
    pe= pe_ref; % notably theta=1 and eta= 2.1. the value of m will be changed in computeIO_X
    figure(5)
    Nnom= computeIO_N(m, tspan, x0, pe);
    semilogy(m, Nnom); legend('N you', 'N you R', 'N you I', 'N you RI');  xlabel('Inducer concentration'); ylabel('Steady State cell density : CFU/mL'); title({'Evolution of the steady state cell densities of N';'as a function of the concentration of inducer'}); hold on;
    
    figure(6)
    Enom= computeIO_E(m, tspan, x0, pe);
    semilogy(m, Enom); legend('E you', 'E you R', 'E you I', 'E you RI');   xlabel('Inducer concentration'); ylabel('Specie concentration : nM'); title({'Evolution of the steady state cell densities of E';'as a function of the concentration of inducer'});hold on;
    
    figure(7)
    Anom= computeIO_A(m, tspan, x0, pe);
    semilogy(m, Anom); legend('A you', 'A you R', 'A you I', 'A you RI');  xlabel('Inducer concentration'); ylabel('Specie concentration : nM'); title({'Evolution of the steady state cell densities of A';'as a function of the concentration of inducer'}); hold on;

    %compute mean square deviation with respect to nominal behavior for the 3 models and for specific parameter values
    pe= pe_ref;
    pe([9 10])= [0.4 2.4];
    %msd(1) stores the msd for E in model R
    %msd(2) stores the msd for A in model R
    %msd(3) stores the msd for E in model I
    %msd(4) stores the msd for A in model I
    %msd(5) stores the msd for E in model RI
    %msd(6) stores the msd for A in model RI
    msd(1)= compute_msd(m,tspan,x0,pe,pe_ref,1,1);
    msd(2)= compute_msd(m,tspan,x0,pe,pe_ref,1,2);
    msd(3)= compute_msd(m,tspan,x0,pe,pe_ref,2,1);
    msd(4)= compute_msd(m,tspan,x0,pe,pe_ref,2,2);
    msd(5)= compute_msd(m,tspan,x0,pe,pe_ref,3,1);
    msd(6)= compute_msd(m,tspan,x0,pe,pe_ref,3,2);
    display(['msd: ' num2str(msd)]);
end

%% QUESTION 8

if Q8
    display('--------------Question 8--------------');
    theta= [0.4 0.6 0.8 1 1.2 1.4 1.6];
    eta= [1.8 2 2.2 2.4];
    %theta= [0.4 1 1.6]; % again for debugging, you can use these values instead
    %eta= [1.6 2 2.4];
    msd= zeros(length(theta),length(eta));
    
    % E in R
    for i= 1:length(theta)
        for j= 1:length(eta)
            pe= pe_ref;
            pe([9 10])= [theta(i) eta(j)];
            msd(i,j)= compute_msd(m,tspan,x0,pe,pe_ref,1,1); % here store in msd(i,j) the mean square deviation between the nominal IO behavior and the one one obtains with specific values of theta and eta, if the model is youR, and the observed variable is E
            %use compute_msd and pe
        end
    end
    variance_IO(1)= var(msd(:));
    
    % A in R
    for i= 1:length(theta)
        for j= 1:length(eta)
            pe= pe_ref;
            pe([9 10])= [theta(i) eta(j)];
            msd(i,j)= compute_msd(m,tspan,x0,pe,pe_ref,1,2); % the same as above, but if the model is youR and the observed variable is A
        end
    end
    variance_IO(2)= var(msd(:));
    
    % E in I
    for i= 1:length(theta)
        for j= 1:length(eta)
            pe= pe_ref;
            pe([9 10])= [theta(i) eta(j)];
            msd(i,j)= compute_msd(m,tspan,x0,pe,pe_ref,2,1); % the same as above, but if the model is youI and the observed variable is E
        end
    end
    variance_IO(3)= var(msd(:));
    
    % A in I
    for i= 1:length(theta)
        for j= 1:length(eta)
            pe= pe_ref;
            pe([9 10])= [theta(i) eta(j)];
            msd(i,j)= compute_msd(m,tspan,x0,pe,pe_ref,2,2); % the same as above, but if the model is youI and the observed variable is A
        end
    end
    variance_IO(4)= var(msd(:));
    
    % E in RI
    for i= 1:length(theta)
        for j= 1:length(eta)
            pe= pe_ref;
            pe([9 10])= [theta(i) eta(j)];
            msd(i,j)= compute_msd(m,tspan,x0,pe,pe_ref,3,1);% the same as above, but if the model is youRI and the observed variable is E
        end
    end
    variance_IO(5)= var(msd(:));
    
    % A in RI
    for i= 1:length(theta)
        for j= 1:length(eta)
            pe= pe_ref;
            pe([9 10])= [theta(i) eta(j)];
            msd(i,j)= compute_msd(m,tspan,x0,pe,pe_ref,3,2);% the same as above, but if the model is youRI and the observed variable is A
        end
    end
    variance_IO(6)= var(msd(:));
    
    display(['variance: ' num2str(variance_IO)]); 
    % make your choice here!
end

%% QUESTION 9 

%experimental data should be stored in data.mat file. This file must be in the same folder as your main file
if Q9
    load('data.mat','data');
    figure(8)
    plot(m,data,'x'); legend('A'); hold on  %here, plot the experimental data 
    k(:,1)= pe_ref([9 10]); %here data for reference values for theta and eta
    k_sigma= k/3;
    opts=cmaes;
    opts.DispModulo= 20; %displays info every 20 iterations (default is 100)
    opts.StopFitness= 1e-2; %displays info every 20 iterations (default is 100)
    %[k_opt, cost_min, counteval, stopflag, out, bestever]= cmaes('compute_cost', k, k_sigma,opts,m, tspan, x0, pe_ref, data);
    
    %opts.LBounds = [0.4;1.8]; opts.UBounds = [1.6;2.4];
    [k_opt, cost_min, counteval, stopflag, out, bestever]=cmaes('compute_cost', k, k_sigma,opts,m, tspan, x0, pe_ref, data);
    
    pe=pe_ref;%here define pe such that pe stores the parameters you found
    pe([9 10])=k_opt;
    
    for i=1:length(m)
        pe(8)=m(i); %here pe stores the ith inducer concentration
        [t x]= ode15s(@you_odeR,tspan, x0, [], pe);
        A(i)=x(end,3);  %store in A(i) or E(i) the steady state values for A or E that you computed
    end
    plot(m,A); title({'Computed function fitting the given data';'Circuit R, specie A'} ); legend ('Given data','Computed function'); xlabel('m, concentration of inducer'); ylabel('Steady state concentration of specie A, nM') % plot A or E (the plot goes in figure 8)
    save('k_opt.mat','k_opt'); %save these values to avoid computing them each time
end

%% QUESTION 10 

if Q10
    load('k_opt.mat', 'k_opt'); %reload the optimal parameters found
    pe_opt = pe_ref; % define pe_opt based on pe_ref and k_opt
    pe([9 10]) = k_opt;
    
    % YOU ODE
    pe_opt(8) = 0; % set m=0 in pe_opt  -- line A (for future use)
    [t x]= ode15s(@you_ode,tspan, x0, [], pe_opt); %do the num sim for the you model
    max(1)= x(end,1); %stores the cell density at steady state in max(1)
    
    pe_opt(8) = 3; % set m=3 in pe_opt
    [t x]= ode15s(@you_ode,tspan, x0, [], pe_opt); %do the num sim for the you model
    min(1)= x(end,1);%stores the cell density at steady state in min(1) -- line B (for future use)
    
    % YOU ODE R
    pe_opt(8) = 0; % set m=0 in pe_opt  -- line A (for future use)
    [t x]= ode15s(@you_odeR,tspan, x0, [], pe_opt); %do the num sim for the you model
    max(2)= x(end,1); %stores the cell density at steady state in max(1)
    
    pe_opt(8) = 3; % set m=3 in pe_opt
    [t x]= ode15s(@you_odeR,tspan, x0, [], pe_opt); %do the num sim for the you model
    min(2)= x(end,1);%stores the cell density at steady state in min(1) -- line B (for future use)
    
    %YOU ODE I
    pe_opt(8) = 0; % set m=0 in pe_opt  -- line A (for future use)
    [t x]= ode15s(@you_odeI,tspan, x0, [], pe_opt); %do the num sim for the you model
    max(3)= x(end,1); %stores the cell density at steady state in max(1)
    
    pe_opt(8) = 3; % set m=3 in pe_opt
    [t x]= ode15s(@you_odeI,tspan, x0, [], pe_opt); %do the num sim for the you model
    min(3)= x(end,1);%stores the cell density at steady state in min(1) -- line B (for future use)
    
    %YOU ODE RI
    pe_opt(8) = 0; % set m=0 in pe_opt  -- line A (for future use)
    [t x]= ode15s(@you_odeRI,tspan, x0, [], pe_opt); %do the num sim for the you model
    max(4)= x(end,1); %stores the cell density at steady state in max(1)
    
    pe_opt(8) = 3; % set m=3 in pe_opt
    [t x]= ode15s(@you_odeRI,tspan, x0, [], pe_opt); %do the num sim for the you model
    min(4)= x(end,1);%stores the cell density at steady state in min(1) -- line B (for future use)
    
    % PLOTTING
    figure(9)
    plot(1:4, max./min,'o'); xlabel('Circuits : constitutive(1), R(2), I(3) and RI(4)'); ylabel('Nmax/Nmin'); title({'Impact of the increase of inducer concentration (m= 0 or 3)';'on steady state cell density (N)'}); 

    pe_opt(8) = 0;
    [t x1]= ode15s(@you_odeRI,tspan, x0, [], pe_opt); % compute timed behavior of best model in absence of inducer (behavior stored in x1) or in presence of inducer (behavior stored in x2) 
    pe_opt(8) = 3;
    [t x2]= ode15s(@you_odeRI,tspan, x0, [], pe_opt);
    
    figure(10)
    semilogy(t,x1(:,1)/p_ref(2),'b'); hold on ;
    semilogy(t,x2(:,1)/p_ref(2),'k'); hold on ; xlabel('Time in Hours'); ylabel('N/Nm'); title('N/Nm ratio of circuit RI in absence or presence of inducer'); legend('m=0','m=3')

    plot(t,x1(:,1)); hold on;
    plot(t,x2(:,1));xlabel('Time in Hours'); ylabel('N Cell density, CFU/mL'); title('Timed behavior of circuit RI in absence or presence of inducer'); legend('m=0','m=3')
end
   