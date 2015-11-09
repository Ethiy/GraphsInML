function [W,distances] = build_similarity_graph(graph_type, graph_thresh, X, similarity_function, similarity_options)
%[W, distances] = build_similarity_graph(graph_type, graph_thresh, X, similarity_function, similarity_options)
% Computes the similarity matrix for a given dataset of samples.
% graph_type: knn or eps graph, as a string, controls the graph that
% the function will produce
% graph_thresh: controls the main parameter of the graph, the number
% of neighbours k for k-nn, and the threshold eps for epsilon graphs
% X: is an n x m matrix of m-dimensional samples
% similarity_function: is a function handle that will be applied to
% compute the sample distance
% similarity_options: is a vector containing options for the similarity
% function
% The return value W is an n x n graph matrix, while the distances
% matrix (if requested) contains the full matrix with all the distances


    if nargin < 4
        error('build_similarity_graph: not enough arguments')
    elseif nargin < 5
        similarity_options = [];
    elseif nargin > 6
        error('build_similarity_graph: too many arguments')
    end

    %% Using similarity function to build full graph (distances)  
    distances = similarity_function(X, similarity_options);

    n = size(X,1);
    
    W = zeros(n,n);

    if strcmp(graph_type,'knn') == 1

    %% Compute a k-nn graph from the distances           
    
        k=graph_thresh;
        for i=1:n
            aux=distances(i,:);% auxilary array
            for s=1:k
                [w, indice]=max(aux);
                W(i,indice)=w;
                aux=[aux(1:(indice-1)),eps,aux((indice+1):n)];
            end
        end
        W=(W+W')/2;
        
        %NNInd=zeros(n,k); % Nearest neighbors indices
        %Xsorted=zeros(n,n); % sorted weights for each node
        %for i=1:n
        %    [~,Xsorted(i,:)] = sort(-distances(i,:)); % descending order
        %    NNInd(i,:) = Xsorted(i,1:k); % k NN indices for each node
        %end
        %for i=1:n
        %    for j=1:k
        %        W(i,NNInd(i,j))=distances(i,NNInd(i,j));
        %        W(NNInd(i,j),i)= W(i,NNInd(i,j));% OR graph: we keep the two edges
        %    end
        %    W(i,i)=1;
        %end
    

    elseif strcmp(graph_type,'eps') == 1

    %% Compute an epsilon graph from the distances       
        W(distances > graph_thresh)= distances(distances > graph_thresh);% we keep edges with weight over graph_thresh

    else

        error('build_similarity_graph: not a valid graph type')

    end
end

