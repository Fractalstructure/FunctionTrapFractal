function bubble_min_modulus()
% TRADITIONAL "BUBBLE" METHOD (FIG.4 LEFT)
% Uses Euclidean norm to generate fractals via Algorithm 2 (Minimum Value Function Trap).
% Reference: Section 4.4 "Extended Minimum Modulus Method" in the manuscript.

% Image resolution
WIDTH = 4096;       % Number of points along the x-axis
HEIGHT = 2048;      % Number of points along the y-axis

% Fractal region in the complex plane
X_MIN = -2.8; X_MAX = 2.8;    % Real axis range
Y_MIN = -1.4; Y_MAX = 1.4;    % Imaginary axis range

% Algorithm parameters
MAX_ITERATION = 30;    % Maximum iterations per point
EPSILON = 0.5;         % Trap size threshold

% Generate grid points
x = linspace(X_MIN, X_MAX, WIDTH);
y = linspace(Y_MIN, Y_MAX, HEIGHT);
[X, Y] = meshgrid(x, y);

% Initialize output matrix and progress bar
zval = zeros(HEIGHT, WIDTH);
h = waitbar(0, 'Generating "Bubble" Fractal...');

tic;  % Start timer
for row = 1:HEIGHT
    for col = 1:WIDTH
        zn = 0;                  % Initial value: z0 = 0
        c = X(row, col) + 1i * Y(row, col);
        min_mod = Inf;           % Track minimum modulus
        
        for iter = 1:MAX_ITERATION
            zn = zn^2 + c;       % Iteration formula
            current_mod = abs(zn); 
            if current_mod < min_mod
                min_mod = current_mod;  % Update minimum modulus
            end
        end
        
        % Assign color index based on minimum modulus
        if min_mod < EPSILON
            zval(row, col) = (min_mod / EPSILON) * 255;
        else
            zval(row, col) = 255;
        end
    end
    waitbar(row / HEIGHT, h);
end
toc;  % Stop timer

close(h);
imwrite(zval, hot(256), 'bubble_min_modulus.png');  % Save image
end