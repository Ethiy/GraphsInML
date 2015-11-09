% Create non observable graph
function W = nonObservableGraph(n)

W=zeros(n,n);

% non observable vertices
nonObservableNumber=randi(n);
NonObservable = randi(n,1,nonObservableNumber);

for i=1:n
    if length(find(NonObservable == i)) == 0
        numberNonZeros=randi(n);
        W(randi(n,1,numberNonZeros),i)=ones(numberNonZeros,1);
    end
end

end