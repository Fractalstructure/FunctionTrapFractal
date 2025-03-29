function neuron_julia()
% NEURON METHOD (JULIA VARIANT, FIG.2 RIGHT)
% Generates neuron-like fractals using logarithmic product trap (Algorithm 1).
% Reference: Section 4.2 "Neuron Method" in the manuscript.

% Image resolution
WIDTH = 4096;       
HEIGHT = 2048;      

% Julia set parameters
c = 0.6 + 0.3i;  % Fixed Julia parameter
X_MIN = -2.8; X_MAX = 2.8;
Y_MIN = -1.4; Y_MAX = 1.4;

% Algorithm parameters
MAX_ITERATION = 30;    
EPSILON = 0.04;       % Trap size for Julia variant

% Generate grid points
x = linspace(X_MIN, X_MAX, WIDTH);
y = linspace(Y_MIN, Y_MAX, HEIGHT);
[X, Y] = meshgrid(x, y);

% Initialize output matrix
zval = zeros(HEIGHT, WIDTH);
h = waitbar(0, 'Generating Neuron Julia Fractal...');

tic;
for row = 1:HEIGHT
    for col = 1:WIDTH
        zn = X(row, col) + 1i * Y(row, col);  % Initial z0 = grid point
        trapped = false;
        
        for iter = 1:MAX_ITERATION
            zn = zn^2 + c;  

            % Compute logarithmic product trap
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
                % Assign color index and exit iteration
                zval(row, col) = (trap_value / EPSILON) * 255;
                trapped = true;
                break;
            end
        end
        
        if ~trapped
            zval(row, col) = 255;  % Default color if not trapped
        end
    end
    waitbar(row / HEIGHT, h);
end
toc;

close(h);
imwrite(zval, flipud(hot(256)), 'neuron_julia.png');  % Save with inverted colormap
end