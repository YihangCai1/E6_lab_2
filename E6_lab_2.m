function E6_lab_2()
    r1 = 0.1875;
    r2 = 0.75;
    wt = 3.02; % lb
    cw1 = [31.5, 62.75, 29.75];
    cw2 = [50.75, 61, 78.75];
    cw3 = [13, 62, 70.75];
    
    w3 = [-95.5, 64, 116.6929];
    w4 = [94.5, 64, 116.7323];
    
    wt1 = [1.6945; 2.432];
    wt2 = [2.6215; 3.4845];
    wt3 = [3.185; 3.4845];

    function new_Z = correctZ(gd, z)
            new_gd = gd - r1; % Calculate the new distance by substracting r.
            alpha = atand(z/new_gd); % Calculate the angle of the smaller triangle.
            hyp = norm([new_gd, z]); % Calculate the hypotenuse based on the new distance and the original z.
            beta = asind(r1/hyp); % Calculate the angle between the large and the small triangles.
            theta = alpha + beta; % Summing the angles gets the angle of the larger triangle.
            new_Z = gd*tand(theta); % Calculate the opposite of the larger triangle, which is the corrected Z coord.
    end
    
    function lam = findLam(w, c)
        x = w(1)-c(1); % Find the x and y component of the distance vector from the center mass to the weight.
        y = w(2)-c(2);
        gd = norm([x,y]); % Find the ground distance, which is the norm of x and y. 
        new_w = [w(1), w(2), correctZ(gd, w(3))]; % Correct Z using the correctZ function to find the corrected Z.
        T = new_w-c; % Find the corrected tension vector.
        lam = T/norm(T); % Calculate the lambda by dividing the norm.
    end    
    
    function tensions = findTensions(c)
        lam3 = findLam(w3, c);
        lam4 = findLam(w4, c);
        lam3 = [lam3(1); lam3(3)];
        lam4 = [lam4(1); lam4(3)];
        matrix = [lam3,lam4]; % Assemble the matrix, and solve for the system using the known constant weight. 
        tensions = matrix\[0;wt];% or we can use: tensions = inv(matrix)*[0;0;wt], as discussed on class.
    end


    function friction = findFriction(c, wt)
        t = findTensions(c);
        f = abs(t - wt)*r2/r1 % Resistance
        
    end
    findFriction(cw1, wt1);
end