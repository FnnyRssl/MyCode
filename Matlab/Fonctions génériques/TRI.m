function [Filtered, Removed] = TRI (Data, Columns)

Size=size(Data);
J=Columns; % vector with the column numbers where we don't want any 999999.
% INDEXES = [187 193 194 189 192 190 191 182 183 186];
SizeJ=size(J);
Removed=[];

for i=Size(1):-1:1
    
    SUM=0;
    
    for j=1:SizeJ(2)
        SUM= SUM + Data(i,J(j));   % sum of all the data we want to observe (see J) for the observed patient (#i)
    end
    
    if SUM> 999999 || Data_face(i,187)>9.5 || Data_face(i,196)>15 || Data_face(i,252)>200 % remove all values with 9999 in relevant columns AND remove patients with CRP strictly above 9.5 AND remove patients with MADRS > 15 AND removing patient 70320 who has mathys_tot >200
        Removed(end+1,:)=Data(i,:);
        Data(i,:)=[];
        
    end
    
end

Filtered=Data;

end
