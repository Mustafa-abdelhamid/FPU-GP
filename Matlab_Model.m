% A_double = 1.8;
% A_single = single(A_double);
% A_single_binary = dec2bin(typecast(A_single,'uint32'),32);

% a = -5;
% b = 5;
% r = (b-a).*rand(1000,1) + a; %generate random floating point numbers from a to b.

%% generating exponents of the first operand.
min_exponent = -127;
max_exponent = 128;
exponent_x = randi([min_exponent max_exponent],1,1000); % 1000 exponents
exponent_x = exponent_x';
%% generating mantessas of the first operand.
min_mantessa = -2;
max_mantessa = 2;
mantessa_x = (max_mantessa - min_mantessa).*rand(1000,1) + min_mantessa; %1000 mantessas
%% generating the first operand in IEEE 754 standard format is single precision.
two_power_exponent_x = 2.^(exponent_x);
x = mantessa_x.*two_power_exponent_x;
x_single = single(x);
x_single_binary = dec2bin(typecast(x_single,'uint32'),32);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%% generating exponents of the second operand.
min_exponent = -127;
max_exponent = 128;
exponent_y = randi([min_exponent max_exponent],1,1000); % 1000 exponents
exponent_y = exponent_y';
%% generating mantessas of the second operand.
min_mantessa = -2;
max_mantessa = 2;
mantessa_y = (max_mantessa - min_mantessa).*rand(1000,1) + min_mantessa; %1000 mantessas
%% generating the first operand in IEEE 754 standard format is second precision.
two_power_exponent_y = 2.^(exponent_y);
y = mantessa_y.*two_power_exponent_y;
y_single = single(y);
y_single_binary = dec2bin(typecast(y_single,'uint32'),32);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% addition operation.
addition_result_single = x_single + y_single;
addition_result_single_binary = dec2bin(typecast(addition_result_single,'uint32'),32);
%% subtraction operation.
subtraction_result_single = x_single - y_single;
subtraction_result_single_binary = dec2bin(typecast(subtraction_result_single,'uint32'),32);
%% multiplication operation.
multiplier_result_single = x_single .* y_single;
multiplier_result_single_binary = dec2bin(typecast(multiplier_result_single,'uint32'),32);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% generating vector of the first operand sign.
S_x = zeros(1000,1);
for i=1:1000
    S_x(i) = x_single_binary(i,32);
end