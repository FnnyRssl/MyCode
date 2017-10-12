function [T La Te] = plot_p(p)


xlabel('LacI (copy numbers)')
ylabel('TetR (copy numbers)')
axis ([0 2500 0 2500]);

LacI_vector= linspace(0,2500,300);
TetR_vector= linspace(0,2500,300);
for i=1:length(LacI_vector)
    mRNAt = (p(2) + p(4)/(1 + (LacI_vector(i)/p(5))^p(7)))/p(10); 
    nTetR_vector(i)= (p(12).*mRNAt)./p(14);
end
for j=1:length(TetR_vector)
    mRNAl = (p(1) + p(3)/(1 + (TetR_vector(j)/p(6))^p(8)))/p(9);                   
    nLacI_vector(j)= (p(11).*mRNAl)./p(13);
end
plot(nLacI_vector,TetR_vector,'g','LineWidth',4);
plot(LacI_vector,nTetR_vector,'c','LineWidth',4);
[X0,Y0] = intersections(LacI_vector, nTetR_vector, nLacI_vector, TetR_vector);
plot(X0,Y0,'o');
legend('LacI nullcline', 'TetR nullcline');

end

