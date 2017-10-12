function [Best_score, Best_fit, Works, Fails] = Regression_Test( Data, tmax, ON_OFF, Best_fit, Best_score, R )

Works = 0;
Fails = 0;
Ratio=0;

if R~=1
Best_score=0;
end

G=1; % If G=1, ordinal logistic regression

for j=1:tmax
    
    W=0;
    F=0;
    
    %Working on pop
    %Pop=[Data(:,187) Data(:,194) Data(:,195) Data(:,189) Data(:,192) Data(:,190) Data(:,191) Data(:,193) Data(:,182) Data(:,183) Data(:,186)];
    %Pop(:,12)=Data(:,894);
    
    Pop=Data;
    Rand_pop=Pop(randperm(size(Pop,1)),:); %randomize the order of the Data
    Size=size(Pop);
    
    Rand=[];
    
    % Number of each category we want to select randomly
    NHypo=45; %init:45
    NNorm=70; %init:70
    NHyper=90; %init:90
    
    for i=1:Size(1);
        
        if Rand_pop(i,12)==1 && NHypo > 0
            Rand(end+1,:)=Rand_pop(i,:);
            NHypo=NHypo-1;
            continue
        elseif Rand_pop(i,12)==2 && NNorm > 0
            Rand(end+1,:)=Rand_pop(i,:);
            NNorm=NNorm-1;
            continue
        elseif Rand_pop(i,12)==3 && NHyper > 0
            Rand(end+1,:)=Rand_pop(i,:);
            NHyper=NHyper-1;
            continue
        end
    end
    
    Size=size(Rand);
    Base=Rand_pop(Size(1)+1:end,:); % Regroups all the remaining Data in a new matrix, to feed the Multinomial regression algorythm.
    
    % We have :
    %Base = the population on which we compute the multinomial regression
    %Rand = the population on which we test the function
    
    Base_1=Base;
    Rand_1=Rand;
    Base_2=Base;
    Rand_2=Rand;
    Base_3=Base;
    Rand_3=Rand;
    
    % Modifying Base_2 and Base_3 11 column
    Size=size(Base);
    for i=1:Size(1)
        if Base_2(i,12)==1
            Base_2(i,12)=3;
        elseif Base_2(i,12)==2
            Base_2(i,12)=1;
        else
            Base_2(i,12)=2;
        end
        
        if Base_3(i,12)==1
            Base_3(i,12)=1;
        elseif Base_3(i,12)==2
            Base_3(i,12)=3;
        else
            Base_3(i,12)=2;
        end
        
    end
    
    % Modifying Rand_2 and Rand_3 11th column
    Size=size(Rand);
    for i=1:Size(1)
        
        if Rand_2(i,12)==1
            Rand_2(i,12)=3;
        elseif Rand_2(i,12)==2
            Rand_2(i,12)=1;
        else
            Rand_2(i,12)=2;
        end
        
        if Rand_3(i,12)==1
            Rand_3(i,12)=1;
        elseif Rand_3(i,12)==2
            Rand_3(i,12)=3;
        else
            Rand_3(i,12)=2;
        end
    end
    
    %%
    
    if ON_OFF ==1
        
        sp_1=categorical(Base_1(:,12)); % Creates a three category file according to the classifincation (column 11) = 1:Hypo 2:Normal 3:Hyper in our Base file;
        [B1, ~, ~] = mnrfit(Base_1(:,1:11),sp_1);
        
        sp_2=categorical(Base_2(:,12));
        [B2, ~, ~] = mnrfit(Base_2(:,1:11),sp_2);
        
        sp_3=categorical(Base_3(:,12));
        [B3, ~, ~] = mnrfit(Base_3(:,1:11),sp_3);
        
    else
        B1 = Best_fit(1:12,:);
        B2 = Best_fit(13:24,:);
        B3 = Best_fit(25:36,:);
        
    end
    
    
    % We obtain intercepts terms for the relative risk of the first two
    % categories (Hypo, Normal), versus the third one (Hyper);
    
    % The probability of belonging to the Hypo category :
    Size=size(Rand);
    
    for i=1:Size(1)
        
        Para=Rand(i,:);
        
        % 1=Hypo 2=Normal
        Proba_1_1= exp (B1(1,1)+ B1(2,1) * Para(1) + B1(3,1) * Para(2) + B1(4,1) * Para(3) + B1(5,1) * Para(4) + B1(6,1) * Para(5) + B1(7,1) * Para(6) + B1(8,1) * Para(7) + B1(9,1) * Para(8)+ B1(10,1) * Para(9) + B1(11,1) * Para(10) + B1(12,1) * Para(11));
        Proba_1_2= exp (B1(1,2)+ B1(2,2) * Para(1) + B1(3,2) * Para(2) + B1(4,2) * Para(3) + B1(5,2) * Para(4) + B1(6,2) * Para(5) + B1(7,2) * Para(6) + B1(8,2) * Para(7) + B1(9,2) * Para(8)+ B1(10,2) * Para(9) + B1(11,2) * Para(10) + B1(12,2) * Para(11));
        
        % 1=Normal 2=Hyper
        Proba_2_1= exp (B2(1,1)+ B2(2,1) * Para(1) + B2(3,1) * Para(2) + B2(4,1) * Para(3) + B2(5,1) * Para(4) + B2(6,1) * Para(5) + B2(7,1) * Para(6) + B2(8,1) * Para(7) + B2(9,1) * Para(8)+ B2(10,1) * Para(9) + B2(11,1) * Para(10) + B2(12,1) * Para(11));
        Proba_2_2= exp (B2(1,2)+ B2(2,2) * Para(1) + B2(3,2) * Para(2) + B2(4,2) * Para(3) + B2(5,2) * Para(4) + B2(6,2) * Para(5) + B2(7,2) * Para(6) + B2(8,2) * Para(7) + B2(9,2) * Para(8)+ B2(10,2) * Para(9) + B2(11,2) * Para(10) + B2(12,2) * Para(11));
        
        % 1=Hypo 2=Hyper
        Proba_3_1= exp (B3(1,1)+ B3(2,1) * Para(1) + B3(3,1) * Para(2) + B3(4,1) * Para(3) + B3(5,1) * Para(4) + B3(6,1) * Para(5) + B3(7,1) * Para(6) + B3(8,1) * Para(7) + B3(9,1) * Para(8)+ B3(10,1) * Para(9) + B3(11,1) * Para(10) + B3(12,1) * Para(11));
        Proba_3_2= exp (B3(1,2)+ B3(2,2) * Para(1) + B3(3,2) * Para(2) + B3(4,2) * Para(3) + B3(5,2) * Para(4) + B3(6,2) * Para(5) + B3(7,2) * Para(6) + B3(8,2) * Para(7) + B3(9,2) * Para(8)+ B3(10,2) * Para(9) + B3(11,2) * Para(10) + B3(12,2) * Para(11));
        
        %Selecting the biggest score in every couple
        
        if Proba_1_1 < Proba_1_2
            Score(1)= 2;
        else
            Score(1)= 1;
        end
        
        if Proba_2_1 < Proba_2_2
            Score(2)= 3;
        else
            Score(2)= 2;
        end
        
        if Proba_3_1 < Proba_3_2
            Score(3)= 3;
        else
            Score(3)= 1;
        end
        
        % If a model is predicted twice, it does correspond to
        % prediction
        if Score(1)==Score(2)
            Score(4)=Score(1);
        elseif Score(2)==Score(3)
            Score(4)=Score(2);
        elseif Score(3)==Score(1)
            Score(4)=Score(3);
        else
            Score(4)=0;
        end
        
        if Score(4)== Para(12);
            Works=Works+1;
            W=W+1;
        else
            Fails=Fails+1;
            F=F+1;
        end
        
    end
    
    Ratio=W./(W+F);
    
    if Ratio > Best_score
        Best_fit= [B1;B2;B3];
        Best_score=Ratio;
    end
    
end


