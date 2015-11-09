% Create random strongly observable graph
function W = strongGraph(n)

W=zeros(n,n);

for i=1:n
    bernoulliParameter = rand;
    if rand <= bernoulliParameter 
        W(i,i)=1;
        numberNonZeros=randi(n);
        W(randi(n,1,numberNonZeros),i)=ones(numberNonZeros,1);
     else
        W(:,i)=ones(n,1);
        W(i,i)=0;
    end    
end

end