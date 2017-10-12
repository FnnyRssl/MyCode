
function [Checked]= Upload_column(Init_base,New_base,Column_numb)
%Uploading a certain column of the initial base ('Face_checked') with new data

Data=Init_base;
Column=New_base;
n=Column_numb;

Size=size(Data);
Size2=size(Column);

for i=1:Size(1)
    for j=1:Size2(1)
        
        if Column(j,1) == Data(i,1)
            Data(i,n)=Column(j,2);
            
        end
        
    end
    
end


end
