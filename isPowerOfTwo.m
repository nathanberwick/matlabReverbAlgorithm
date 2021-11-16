function output = isPowerOfTwo(input)
if (input == 0)
    output = false;
    return
end

if (ceil(log2(input)) == floor(log2(input)))
    output = true;
else
    output = false;
end