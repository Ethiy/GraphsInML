function [ARI] = spectral_clustering(graph_type, graph_thresh)
% spectral_clustering
% a skeleton function to perform spectral clustering, needs to be completed
% graph_type, graph_thresh: in batch mode, control the graph construction,
%                           when missing simply plot the result
% ARI: return the quality of the clustering


    %% The number of samples to generate
    num_samples = 500;

    %% The sample distribution function with the options necessary for the distribuion

    sample_dist = @blobs;
    dist_options = [2, 0.05, 0]; % blobs: number of blobs, variance of gaussian
    %                                    blob, surplus of samples in first blob

    %sample_dist = @two_moons;
    %dist_options = [1, 0.02]; % two moons: radius of the moons,
    %                                   variance of the moons

    sample_dist = @point_and_circle;
    dist_options = [7, 3]; % point and circle: radius of the circle,
    %                           variance of the circle

    plot_results = 0;

    if nargin < 1

        plot_results = 1;

        %% The type of the graph to build and the respective threshold

        graph_type = 'knn';
        graph_thresh = 7; % the number of neighbours for the graph

        %graph_type = 'eps';
        %graph_thresh = 0.5; % the epsilon threshold

    end

    %% Similarity function
    similarity_function = @exponential_euclidean;

    %% Similarity options
    similarity_options = [10]; % exponential_euclidean: sigma

    [X, Y] = get_samples(sample_dist, num_samples, dist_options);

    %% Automatically infer number of labels from samples
    num_classes = length(unique(Y));

    %% Using the build_similarity_graph function to build the graph W  

    W = build_similarity_graph(graph_type, graph_thresh, X, similarity_function, similarity_options);



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


    %% Sorting the eigenvalues
    [eigenvalues_sorted,reorder] = sort(diag(E));

    eig_ind = 2; % the interesting eigen vectors

    U = U(:,reorder(eig_ind));

    %% Computing the clustering assignment from the eigenvector   


    label = kmeans(U,2,'start','sample');% K means
    %label = (U>0); % Thresholding


    if plot_results
        plot_clustering_result(X,Y,W,label,kmeans(X,num_classes));
    end

    if nargout ==1
        ARI = ari(Y,label);
    end
end