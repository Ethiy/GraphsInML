function [] = plot_edges_and_points(X,Y,W,title_str)

    title(title_str);

    hold on;

    gplot(W,X);

    classes = unique(Y);

    classes_colors = {'go','ro','co','ko','yo','mo'};


    for i = 1:length(classes)
        plot(X(Y == classes(i),1), X(Y == classes(i),2), classes_colors{i},'LineWidth',2);
    end

    axis equal;

    hold off;
