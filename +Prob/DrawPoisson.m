function DrawPoisson

    colorstring = 'kbg';
    figure(1); cla;
    hold on
    x = 0:25;
    y = [poisspdf(x,3.2);poisspdf(x,7.4);poisspdf(x,12.3)];
    p = 0:2;
    for i = 1:3
      p(i) = plot(x,y(i, :), '.', 'Color', colorstring(i),'MarkerSize',15)
    end
    
    h = legend (p, '\lambda = 3.2', '\lambda = 7.4', '\lambda = 12.3');
    xlabel('k');
    ylabel('p(k;\lambda)');
end

