function [eig_ind] = choose_eigenvalues(eigenvalues)
    % choose_number_of_eigenvalues
    % receives in input a sorted list of eigenvalues
    % and returns the indexes of the one that will be used to
    % chose the eigenvectors for the clustering.
    % e.g. [1,2,3,5] 1st, 2nd, 3rd, and 5th smallest eigenvalues
    
    ind=sum(eigenvalues<eps);
    eig_ind=1:ind;
end

