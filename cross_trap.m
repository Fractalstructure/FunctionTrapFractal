function cross_trap()
% CLASSIC CROSS-SHAPED BIOMORPHS (FIG.3 LEFT)
% Uses minimum distance to axes (Pickover Stalk) with ¦Å=0.02.
% Reference: Section 4.3 "Extended Pickover Stalk Method" in the manuscript.

WIDTH = 4096;       % X-axis resolution
HEIGHT = 2048;      % Y-axis resolution
X_MIN = -2.8; X_MAX = 2.8;    % Real axis range
Y_MIN = -1.4; Y_MAX = 1.4;    % Imaginary axis range
MAX_ITERATION = 30; % Maximum iterations
EPSILON = 0.02;     % Trap threshold

% Generate grid
x = linspace(X_MIN, X_MAX, WIDTH);
y = linspace(Y_MIN, Y_MAX, HEIGHT);
[X, Y] = meshgrid(x, y);
zval = zeros(HEIGHT, WIDTH);
h = waitbar(0, 'Generating Cross-Trap Fractal...');

tic;
for row = 1:HEIGHT
    for col = 1:WIDTH
        zn = 0;                  % Initial z0 = 0
        c = X(row, col) + 1i * Y(row, col);
        trapped = false;
        
        for iter = 1:MAX_ITERATION
            zn = zn^2 + c;
            re = real(zn); im = imag(zn);
            
            % Compute minimum distance to axes
            distance = min(abs(re), abs(im));
            
            if distance < EPSILON
                zval(row, col) = ((EPSILON - distance)/EPSILON) * 255;
                trapped = true;
                break;
            end
        end
        
        if ~trapped
            zval(row, col) = 255;  % Default color
        end
    end
    waitbar(row/HEIGHT, h);
end
toc;

close(h);
imwrite(zval, hot(256), 'cross_trap.png');
end