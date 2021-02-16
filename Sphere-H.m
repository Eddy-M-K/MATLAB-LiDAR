function Sphere(X, Y, Z, r)
    [i j k] = sphere;
    i = i * r;
    j = j * r;
    k = k * r;
    surf(i + X, j + Y, k + Z);
end

