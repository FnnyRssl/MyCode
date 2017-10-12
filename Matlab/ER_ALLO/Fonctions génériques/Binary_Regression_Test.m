function [B, Rand] = Binary_Regression_Test(Data, Groups)

% Groups(1) & Groups(2) are the observed groups, where Groups(3) is the
% excluded one. 

    %Working on pop
    %Pop=[Data(:,187) Data(:,194) Data(:,195) Data(:,189) Data(:,192) Data(:,190) Data(:,191) Data(:,193) Data(:,182) Data(:,183) Data(:,186)];
    %Pop(:,12)=Data(:,894);
    
    Pop=Data;
    Rand_pop=Pop(randperm(size(Pop,1)),:); %randomize the order of the Data
    Size=size(Pop);
    
    Rand=[];
    
    % Number of each category we want to select randomly
    NA=70; %init:45
    NB=70; %init:70   
    
    for i=1:Size(1);
        
        if Rand_pop(i,12)==Groups(1) && NA > 0
            Rand(end+1,:)=Rand_pop(i,:);
            NA=NA-1;
            continue
        elseif Rand_pop(i,12)==Groups(2) && NB > 0
            Rand(end+1,:)=Rand_pop(i,:);
            NB=NB-1;
            continue
        end
    end
    
    Size=size(Rand);
    Base=Rand_pop(Size(1)+1:end,:); % Regroups all the remaining Data in a new matrix, to feed the Multinomial regression algorythm.
    
    Size=size(Base);
    
    for i=Size(1):-1:1
        if Base(i,12)==Groups(3)
            Base(i,:)=[];
        end
    end 
                    
    % We have :
    %Base = the population on which we compute the multinomial regression
    %Rand = the population on which we test the function
       


        sp=categorical(Base(:,12)); % Creates a three category file according to the classifincation (column 11) = 1:Hypo 2:Normal 3:Hyper in our Base file;
        [B, ~, ~] = mnrfit(Base(:,1:11),sp);
        
           
    % We obtain intercepts terms for the relative risk of the first two
    % categories (Hypo, Normal), versus the third one (Hyper);
  
    
   end


