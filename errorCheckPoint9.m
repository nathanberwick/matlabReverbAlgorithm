function output = errorCheckPoint9(input)

output = input;

if (input > 0.9)
    output = 1;
elseif (input < 0)
    output = 0;
end