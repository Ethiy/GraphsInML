function [] = how_to_choose_epsilon(graph_type, graph_thresh, X, similarity_function, similarity_options)
% how_to_choose_epsilon
% a skeleton function to analyze the influence of the graph structure
% on the epsilon graph matrix


    %% The number of samples to generate
    num_samples = 100;

    %% The sample distribution function
    sample_dist = @worst_case_blob;

    %% The type of the graph to build
    graph_type = 'eps';

    %% The options necessary for the distribution
    dist_options = [3]; % read worst_case_blob.m to understand the meaning of
    %                               the parameter

    %% Similarity function
    similarity_function = @exponential_euclidean;

    %% Similarity options
    similarity_options = [.5]; % exponential_euclidean: sigma

    [X, Y] = get_samples(sample_dist, num_samples, dist_options);

    %% Building the minimum spanning tree min_tree                  
    
    full = similarity_function(X, similarity_options);% full weighted graph matrix
    minsptree = min_span_tree(full); % MST for the full graph
    minsptree=minsptree.*full; % Puts weights back on the tree
    

    %% Setting graph_thresh to the minimum weight in min_tree           

    aux=minsptree(minsptree>0); % auxilary vector of The MST weighted edges
    graph_thresh_ = min(aux); % array of the minimal weights
    graph_thresh=graph_thresh_(1); % the value of the minimum of MST weights


    %% Using the build_similarity_graph function to build the graph W  

    W=build_similarity_graph(graph_type, graph_thresh, X, similarity_function, similarity_options);

    %% Graph plot
    
    plot_graph_matrix(X,W);
end
