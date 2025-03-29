function multiplicative_trap()
% MULTIPLICATIVE TRAP VARIANT (FIG.3 RIGHT)
% Uses product of real/imaginary parts (g(z) = |Re(z)¡¤Im(z)|).
% Reference: Section 4.3 "Extended Pickover Stalk Method".

WIDTH = 4096; HEIGHT = 2048;
X_MIN = -2.8; X_MAX = 2.8;
Y_MIN = -1.4; Y_MAX = 1.4;
MAX_ITERATION = 30;
EPSILON = 0.005;   % From Table 1

x = linspace(X_MIN, X_MAX, WIDTH);
y = linspace(Y_MIN, Y_MAX, HEIGHT);
[X, Y] = meshgrid(x, y);
zval = zeros(HEIGHT, WIDTH);
h = waitbar(0, 'Generating Multiplicative Trap Fractal...');

tic;
for row = 1:HEIGHT
    for col = 1:WIDTH
        zn = 0;
        c = X(row, col) + 1i * Y(row, col);
        
        for iter = 1:MAX_ITERATION
            zn = zn^2 + c;
            product = abs(real(zn) * imag(zn));
            
            if product < EPSILON
                zval(row, col) = ((EPSILON - product)/EPSILON) * 255;
                break;
            end
        end
    end
    waitbar(row/HEIGHT, h);
end
toc;

close(h);
imwrite(zval, hot(256), 'multiplicative_trap.png');
end