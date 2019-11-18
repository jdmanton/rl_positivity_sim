function otf = paraxial_otf(n, lambda, numerical_aperture, pixel_size)

resolution  = 0.5 * lambda / numerical_aperture;

image_centre_x = n / 2 + 1;
image_centre_y = n / 2 + 1;

x = (1:n) - image_centre_x;
y = -(1:n) + image_centre_y;
[X, Y] = meshgrid(x, y);

filter_radius = 2 * pixel_size / resolution;
r = sqrt(X.^2 + Y.^2);
r = r / max(x);
v = r / filter_radius;
otf = 2 / pi * (acos(v) - v .* sqrt(1 - v.^2)) .* (r <= filter_radius);
otf = ifftshift(otf);
