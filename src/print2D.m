function print2D(px,py)
    hold on
    rectangle('Position',[-1.27/2 -2.54/2 1.27 2.54])
    viscircles([-1.27/2 0; 1.27/2 0; -1.27/2 -2.54/2; -1.27/2 2.54/2; 1.27/2 -2.54/2; 1.27/2 2.54/2],[0.1159+0.0127 0.1159+0.0127 0.1159 0.1159 0.1159 0.1159],'Color','k');
    for i = 1:length(px(:,1))
        plot(px(i,:),py(i,:),'.')
    end
    axis equal
    xlim([-1.27/2 1.27/2])
    ylim([-2.54/2 2.54/2])
    set(gca,'view',[90 90])
end