function DrawBoxTest()
    close all

    quiver3(0,0,0,0,0,5,'color','r'); 
    hold on
    DrawBox (2, 2, 2, 0, 0, 0, eul2rotm([pi/4, pi/2 - 0.6155, 0]));
    axis equal;
    
end