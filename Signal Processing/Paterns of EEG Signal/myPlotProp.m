function myPlotProp(my_xlim, my_ylim, my_zlim, my_title, my_xlabel, my_ylabel, my_zlabel, my_legend, my_legend_tit, fontsize)
    grid minor;
    if length(my_xlim)>1
        xlim(my_xlim);
    end
    if length(my_ylim)>1
        ylim(my_ylim);
    end
    if length(my_zlim)>1
        zlim(my_zlim);
    end
    title(my_title, 'interpreter', 'latex', 'fontsize', fontsize+3);
    
    if (class(my_legend) == "cell")
        if my_legend{2} == "out"
            lgd = legend(my_legend{1}, 'interpreter', 'latex', 'location', 'bestoutside' ,'fontsize', fontsize-2);
        elseif my_legend{2} == "best"
            lgd = legend(my_legend{1}, 'interpreter', 'latex', 'location', 'best' ,'fontsize', fontsize-2);
        end
        title(lgd, my_legend_tit, 'interpreter', 'latex', 'fontsize', fontsize-2);
    elseif my_legend ~= "off"
        lgd = legend(my_legend, 'interpreter', 'latex' ,'fontsize', fontsize-2);
        title(lgd, my_legend_tit, 'interpreter', 'latex', 'fontsize', fontsize-2);
    end
    
    xlabel(my_xlabel, 'interpreter', 'latex', 'fontsize', fontsize);
    ylabel(my_ylabel, 'interpreter', 'latex', 'fontsize', fontsize);
    zlabel(my_zlabel, 'interpreter', 'latex', 'fontsize', fontsize);
end
