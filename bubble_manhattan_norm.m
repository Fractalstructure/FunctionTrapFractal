function bubble_manhattan_norm()
% MANHATTAN NORM BUBBLE VARIANT (FIG.4 RIGHT)
% Uses g(z) = |Re(z)| + |Im(z)| with ¦Å=0.6.
% Reference: Section 4.4 "Extended Minimum Modulus Method".

WIDTH = 4096; HEIGHT = 2048;
X_MIN = -2.8; X_MAX = 2.8;
Y_MIN = -1.4; Y_MAX = 1.4;
MAX_ITERATION = 30;
EPSILON = 0.6;      % From Table 1

x = linspace(X_MIN, X_MAX, WIDTH);
y = linspace(Y_MIN, Y_MAX, HEIGHT);
[X, Y] = meshgrid(x, y);
zval = zeros(HEIGHT, WIDTH);
h = waitbar(0, 'Generating Manhattan Bubble...');

tic;
for row = 1:HEIGHT
    for col = 1:WIDTH
        zn = 0;
        c = X(row, col) + 1i * Y(row, col);
        min_value = Inf;  % Track minimum Manhattan norm
        
        for iter = 1:MAX_ITERATION
            zn = zn^2 + c;
            current_value = abs(real(zn)) + abs(imag(zn));
            if current_value < min_value
                min_value = current_value;
            end
        end
        
        if min_value < EPSILON
            zval(row, col) = (min_value / EPSILON) * 255;
        else
            zval(row, col) = 255;
        end
    end
    waitbar(row/HEIGHT, h);
end
toc;

close(h);
imwrite(zval, 1-hot(256), 'bubble_manhattan.png');
end