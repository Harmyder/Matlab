function rotm = eul2rotm(eul)
    % ZYX
    z = eul(1);
    y = eul(2);
    x = eul(3);
    
    rotx = [
        1 0 0;
        0 cos(x) -sin(x);
        0 sin(x) cos(x);
        ];
    roty = [
        cos(y) 0 -sin(y);
        0 1 0;
        sin(y) 0 cos(y);
        ];
    rotz = [
        cos(z) -sin(z) 0;
        sin(z) cos(z) 0;
        0 0 1;
        ];
        
    rotm = rotx * roty * rotz;
end