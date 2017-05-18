function DrawBox(sx, sy, sz, cx, cy, cz, rotm)
    vert = [sx/2 sy/2 -sz/2; 
            -sx/2 sy/2 -sz/2; 
            -sx/2 sy/2 sz/2; 
            sx/2 sy/2 sz/2; 
            -sx/2 -sy/2 sz/2;
            sx/2 -sy/2 sz/2; 
            sx/2 -sy/2 -sz/2;
            -sx/2 -sy/2 -sz/2];

    vert = vert * rotm';

    vert(:,1) = vert(:,1) - cx;
    vert(:,2) = vert(:,2) - cy;
    vert(:,3) = vert(:,3) - cz;

    fac = [1 2 3 4; 
           4 3 5 6; 
           6 7 8 5; 
           1 2 8 7; 
           6 7 1 4; 
           2 3 5 8];

    patch('Faces',fac,'Vertices',vert,'FaceColor','b');
    
    xlabel('x')
    ylabel('y')
    zlabel('z')
end