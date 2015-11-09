function [] = find_the_bend()
    % a skeleton function to analyze how the choice of number of eigenvectors
    % influences the clustering
    %

    %% The number of samples to generate
    num_samples = 600;

    %% The sample distribution function
    sample_dist = @blobs;

    %% The type of the graph to build and the respective threshold

    graph_type = 'knn';
    graph_thresh = 5; % the number of neighbours for the graph

    %graph_type = 'eps';
    %graph_thresh = 0.15; % the epsilon threshold

    %% The options necessary for the distribution
    
    dist_options = [4, 0.20, 0]; % blobs: number of blobs, variance of gaussian
    %                                    blob, surplus of samples in first blob

    %% Similarity function
    similarity_function = @exponential_euclidean;

    %% Similarity options
    similarity_options = [0.5]; % exponential_euclidean: sigma


    [X, Y] = get_samples(sample_dist, num_samples, dist_options);

    %% Automatically infer number of labels from samples
    num_classes = length(unique(Y));

    %% Use the build_similarity_graph function to build the graph W  


    W =build_similarity_graph(graph_type, graph_thresh, X, similarity_function, similarity_options);

    %% Building the laplacian                                        

    D=diag(sum(W,2));
    L=D-W;% The laplacian
    d=diag(D);
    d=sqrt(diag(D));
    d=1./d;
    D1=diag(d); % D^-1/2
    Lsym=D1*L*D1;% the symetrized Laplacian


    %% Computing eigenvectors                                      
    
    %n=size(W,1);
    %[U,E]=eig(L);% Diagonalization
    %U=U./norm(U)*sqrt(n);% |U_i|=sqrt(n)
    
    
    [U,E]=eig(Lsym);% Diagonalization
    U=U./norm(U)*trace(D);% |U_i|=Vol(V)
    
    
    
    [eigenvalues_sorted,reorder] = sort(diag(E));
    %plot(eigenvalues_sorted(1:15),'+');

    %% Choosing the number of eigenvectors to use                  
    
    eig_ind = choose_eigenvalues(eigenvalues_sorted);


    U = U(:,reorder(eig_ind));

    [label] = kmeans(U, num_classes,'EmptyAction','singleton','Start','uniform','Replicates',3);

    plot_the_bend(X, Y, W, label, eigenvalues_sorted([eig_ind,max(eig_ind):max(eig_ind)+10]));
end
