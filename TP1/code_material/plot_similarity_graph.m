function [] = plot_similarity_graph()
    % plot_similarity_graph
    % a skeleton function to analyze the construction of the graph similarity
    % matrix

    %% The number of samples to generate
    num_samples = 500;

    %% The sample distribution function with the options necessary for the distribution

    sample_dist = @blobs;
    dist_options = [1, 1, 0]; % blobs: number of blobs, variance of gaussian
    %                                    blob, surplus of samples in first blob

    %sample_dist = @two_moons;
    %dist_options = [1, 0.02]; % two moons: radius of the moons,
    %                                   variance of the moons

    %sample_dist = @point_and_circle;
    %dist_options = [7, 3]; % point and circle: radius of the circle,
    %                           variance of the circle

    %% The type of the graph to build and the respective threshold

    graph_type = 'knn';
    graph_thresh = 5; % the number of neighbours for the graph

    %graph_type = 'eps';
    %graph_thresh = .25; % the epsilon threshold

    %% Similarity function
    similarity_function = @exponential_euclidean;

    %% Similarity options
    similarity_options = [.5]; % exponential_euclidean: sigma

    [X, Y] = get_samples(sample_dist, num_samples, dist_options);

    %% Use the build_similarity_graph function to build the graph W 

    W = build_similarity_graph(graph_type, graph_thresh, X, similarity_function, similarity_options);
    
    
    %% The graph plot
    plot_graph_matrix(X,W);
end
