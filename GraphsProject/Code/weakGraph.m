% Create random weakly observable graph
function W = weakGraph(n)

W=zeros(n,n);

for i=1:n
    numberNonZeros=randi(n);
    W(randi(n,1,numberNonZeros),i)=ones(numberNonZeros,1);
end

end