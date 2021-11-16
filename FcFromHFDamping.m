function output =  FcFromHFDamping(input)

%boundaries
lowerInput = 0;
upperInput = 1;
lowerOutput = 18000;
upperOutput = 22050; %Fs/2, maximum cutoff

input = upperInput - input; %invert

%scale to Fc
output = rescale(input, lowerOutput, upperOutput, 'InputMin', lowerInput, 'InputMax', upperInput);
%still needs logarithmic scaling. for now, this works
