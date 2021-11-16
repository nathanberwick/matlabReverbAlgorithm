function output = gainErrorCheck(inputGain)

x = 4; %12dB boost
output = inputGain;
if (inputGain<=0)
    output = 0;
elseif (inputGain > x)
    output = x;
end