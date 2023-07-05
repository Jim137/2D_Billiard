function print2Dtime(px,py,time)
    r = 0.05715/2;
    figure(1)
    hold on
    rectangle('Position',[-1.27/2 -2.54/2 1.27 2.54])
    viscircles([-1.27/2 0; 1.27/2 0; -1.27/2 -2.54/2; -1.27/2 2.54/2; 1.27/2 -2.54/2; 1.27/2 2.54/2],[0.1159+0.0127 0.1159+0.0127 0.1159 0.1159 0.1159 0.1159],'Color','k');
    axis equal
    xlim([-1.27/2 1.27/2])
    ylim([-2.54/2 2.54/2])
    set(gca,'view',[90 90])
    for t = 1:length(time)
        for i = 1:length(px(:,1))
            viscircles([px(i,t) py(i,t)],[r]);
        end
        title('t = ',time(t))
        drawnow
    end
end