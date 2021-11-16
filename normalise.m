function output = normalise(input)
output = input; %default case - do nothing
if (size(input,1) == 2) %stereo
    output = input / max(max(abs(input)));
elseif (size(input,1) == 1) %mono
    output = input/max(abs(input));
end