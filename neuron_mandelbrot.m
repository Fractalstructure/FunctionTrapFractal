function neuron_mandelbrot()
% NEURON METHOD (MANDELBROT VARIANT, FIG.2 LEFT)
% Uses logarithmic product trap with ¦Å=0.2.
% Reference: Section 4.2 "Neuron Method".

WIDTH = 4096; HEIGHT = 2048;
X_MIN = -2.8; X_MAX = 2.8;
Y_MIN = -1.4; Y_MAX = 1.4;
MAX_ITERATION = 30;
EPSILON = 0.2;      % From Table 1

x = linspace(X_MIN, X_MAX, WIDTH);
y = linspace(Y_MIN, Y_MAX, HEIGHT);
[X, Y] = meshgrid(x, y);
zval = zeros(HEIGHT, WIDTH);
h = waitbar(0, 'Generating Neuron Mandelbrot...');

tic;
for row = 1:HEIGHT
    for col = 1:WIDTH
        zn = 0;  % Mandelbrot starts at z0=0
        c = X(row, col) + 1i * Y(row, col);
        
        for iter = 1:MAX_ITERATION
            zn = zn^2 + c;
            re = max(abs(real(zn)), 1e-10);  % Avoid log(0)
            if real(zn)<0
                re = -re;
            end
            im = max(abs(imag(zn)), 1e-10);
            if imag(zn)<0
                im = -im;
            end
            trap_value = abs(log(re)) * abs(log(im));
            
            if trap_value < EPSILON
                zval(row, col) = (trap_value / EPSILON) * 255;
                break;
            end
        end
    end
    waitbar(row/HEIGHT, h);
end
toc;

close(h);
imwrite(zval, flipud(hot(256)), 'neuron_mandelbrot.png');
end