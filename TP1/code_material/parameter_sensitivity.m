function [] = parameter_sensitivity()
% parameter_sensitivity
% a skeleton function to test spectral clustering
% sensitivity to parameter choice

parameter_candidate = 1:25;

parameter_performance = [];


for i = 1:length(parameter_candidate)

    parameter_performance(i) = spectral_clustering('knn', parameter_candidate(i));

end

plot(parameter_candidate, parameter_performance);
title('parameter sensitivity')


