function [Base] = Reactivity_score ( Database, Column_numb )

Data=Database;
n=Column_numb; % where we want to put the reactivity score : in full database, 894 / in biomarkers, 12

Size=size(Data);
Data(:,894)=0;

for i=1:Size(1)
    if Data(i,247)<16
        Data(i,n)=1;
    elseif Data(i,247)>=16  && Data(i,247) <=24
        Data(i,n)=1;
    elseif Data(i,247)>24 && Data(i,247)<=40
        Data(i,n)=2;
    end  
end

Base=Data;

end

