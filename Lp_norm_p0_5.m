function Lp_norm_p0_5()
% SEA ANEMONE METHOD WITH p=0.5 (FIG.1 LEFT)
% Uses L^p-norm inverse (g(z) = 1/(|Re(z)|^0.5 + |Im(z)|^0.5)^2).
% Reference: Section 4.1 "Sea Anemone Method".

WIDTH = 4096; HEIGHT = 2048;
X_MIN = -2.8; X_MAX = 2.8;
Y_MIN = -1.4; Y_MAX = 1.4;
MAX_ITERATION = 30;
EPSILON = 0.12;     % From Table 1

x = linspace(X_MIN, X_MAX, WIDTH);
y = linspace(Y_MIN, Y_MAX, HEIGHT);
[X, Y] = meshgrid(x, y);
zval = zeros(HEIGHT, WIDTH);
h = waitbar(0, 'Generating Sea Anemone (p=0.5)...');

tic;
for row = 1:HEIGHT
    for col = 1:WIDTH
        zn = 0;  % Mandelbrot variant
        c = X(row, col) + 1i * Y(row, col);
        
        for iter = 1:MAX_ITERATION
            zn = zn^2 + c;
            re = abs(real(zn)); im = abs(imag(zn));
            trap_value = 1 / (re^0.5 + im^0.5)^2;
            
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
imwrite(zval, hot(256), 'sea_anemone_p0.5.png');
end