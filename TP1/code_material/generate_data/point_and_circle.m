function [X, Y] = blobs(num_samples,dist_options)
%dist_options = [0.1, 1, 0.1] % point and circle: radius of the circle, variance of the samples

    circ_radius = dist_options(1);
    circ_var = dist_options(2);

    if mod(num_samples, 2) ~= 0
        error('The number of samples must be a multiple of the number of blobs');
    end

    X = zeros(num_samples,2);

    alpha = 0.6;
    num_samples_circle = round(num_samples*alpha);
    num_samples_point = round(num_samples*(1-alpha));

    X(:,1) = [circ_radius * cos(linspace(0, 2*pi, num_samples_circle)), randn(1, num_samples_point)];
    X(:,2) = [circ_radius * sin(linspace(0, 2*pi, num_samples_circle)), randn(1, num_samples_point)];
    X(1:num_samples_circle,:) = X(1:num_samples_circle,:) + sqrt(circ_var) * randn(num_samples_circle, 2);

    Y = [ ones(num_samples_circle, 1); 2*ones(num_samples_point, 1)];
end

