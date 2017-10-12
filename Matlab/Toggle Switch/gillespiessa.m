function [t,A] = gillespiessa(k,c,p,A0,tend)

%initializations
t= 0;
A= A0;

while t(end)< tend

    r1= rand();
    r2= rand();
    for i=1:size(c,2) %for every reaction i: propensities are a(i)
        if sum(c(:,i))==0 % zeroth order reaction
            a(i)= k(i);
        elseif sum(c(:,i))==1 %first order reaction
            j= find(c(:,i));
            a(i)= k(i)*A(end,j);
        elseif sum(c(:,i))==2 %second order reaction
            j= find(c(:,i));
            if length(j)==2
                a(i)= k(i)*A(end,j(1))*A(end,j(2));
            else
                a(i)= k(i)*A(end,j)*(A(end,j)-1)/2;
            end
        else
            disp('pb!');
        end
    end
    %compute a0, tau and I
    a0= sum(a);
    tau= log(1/r1)/a0;
    I= 1;
    while r2> sum(a(1:I))/a0
        I= I+1;
    end
    A(end+1,:)= A(end,:) - c(:,I)' + p(:,I)';
    t(end+1)= t(end) + tau;
end
t(end)= tend;
A(end,:)= A(end-1,:);

end


