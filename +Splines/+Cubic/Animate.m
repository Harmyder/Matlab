function Animate()
    writerObj = VideoWriter('cubic_spline.avi');
    open(writerObj);
    
    for alpha = -100:100
        clf
        Splines.Cubic.DrawClampedSpline([0 2 4 5 6 7 8 9 10], [0 2 1 3 1 3 1 3 1], alpha, 0);
        
        axis([0 10 -60 60])
        drawnow 
        
        movegui
        set(gca,'Visible','on');
        frame = getframe;
        writeVideo(writerObj,frame);
    end

    close(writerObj);
end