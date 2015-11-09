function [W] = exponential_euclidean(X, similarity_options)
%[W] = exponential_euclidean(X, similarity_options)
% Applies an inverse exponential (Gaussian) function to
% the euclidean distance to generate a similarity measure.
% X is an n x m matrix of m-dimensional samples
% similarity_options is a vector containing options, its first element
% is the sigma^2 value for the exponential function
% The return value W is an n x n dimensional matrix containing the
% distances between each pair of points.

    n=size(X,1);
    W = euclidean(X,similarity_options);
    sigma2=similarity_options(1);
    W=exp(-W/(2*sigma2));%W_{i,j}=exp(|X_i-X_j|/(2*sigma2))
    
end


