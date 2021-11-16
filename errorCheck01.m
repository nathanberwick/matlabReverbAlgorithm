function output = errorCheck01(input)

output = input;

if (input > 1)
    output = 1;
elseif (input < 0)
    output = 0;
end