function [Base,Rand] = Pick_random( Data )

 Pop=Data;
    
    Rand_pop=Pop(randperm(size(Pop,1)),:); %randomize the order of the Data
    Size=size(Pop);
    
    %% Select the random population
    
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
    

end

