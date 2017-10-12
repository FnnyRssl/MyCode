function [X] = get_equilibria(p)

LacI_vector= linspace(0,2000,300);
TetR_vector= linspace(0,2000,300);
for i=1:length(LacI_vector)
    mRNAt = (p(2) + p(4)/(1 + (LacI_vector(i)/p(5))^p(7)))/p(10); 
    nTetR_vector(i)= (p(12).*mRNAt)./p(14);
end
for j=1:length(TetR_vector)
    mRNAl = (p(1) + p(3)/(1 + (TetR_vector(j)/p(6))^p(8)))/p(9);                   
    nLacI_vector(j)= (p(11).*mRNAl)./p(13);
end
[LacI0,TetR0] = intersections(LacI_vector, nTetR_vector, nLacI_vector, TetR_vector);
mRNAt0 = (p(2) + p(4)./(1 + (LacI0/p(5)).^p(7)))./p(10); 
mRNAl0 = (p(1) + p(3)./(1 + (TetR0/p(6)).^p(8)))./p(9);
X= [mRNAl0 mRNAt0 LacI0 TetR0];
end

