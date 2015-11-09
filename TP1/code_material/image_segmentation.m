function [] = image_segmentation()
    % image_segmentation
    

    num_samples = 2500;

    %% The type of the graph to build and the respective threshold
    graph_type = 'knn';
    %graph_type = 'eps';

    %% The threshold or the number of neighbours for the graph
    graph_thresh = 50;
    %graph_thresh = 0.005;

    %% Similarity function
    similarity_function = @exponential_euclidean;

    %% Similarity options
    similarity_options = [20]; % exponential_euclidean: sigma

    X = imread('four_elements','bmp');

    X = reshape(X,2500,3);

    Y = ones(2500,1);
    
    num_classes = length(unique(X));

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
    
    
    [U,E]=eigs(Lsym,20,'sm');% Diagonalization
    U=U./norm(U)*trace(D);% |U_i|=Vol(V)
    
    %% Sorting the eigenvalues
    [eigenvalues_sorted,reorder] = sort(diag(E));
    plot(eigenvalues_sorted(1:15),'+');% plotting the eigenvalues to infere the number of clusters

    eig_ind = 1:8; % the interesting eigen vectors

    U = U(:,reorder(eig_ind));


    label = kmeans(U,8,'EmptyAction','singleton','Start','uniform','Replicates',3);% K means

    set(figure(), 'units', 'centimeters', 'pos', [0 0 20 10]);

    subplot(1,2,1);

    imagesc(reshape(X,50,50,3));

    subplot(1,2,2);
    imagesc(reshape(label,50,50));
end


