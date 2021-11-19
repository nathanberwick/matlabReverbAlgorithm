function output = ERAttenDelay(input, maxERDelay)

% TODO: implement Inverse Square Law instead of scaling.

%boundaries
lowerInput = 0;
upperInput = maxERDelay;
lowerOutput = 0.1;
upperOutput = 0.9;

input = upperInput - input; %invert

%scale to Fc
output = rescale(input, lowerOutput, upperOutput, 'InputMin', lowerInput, 'InputMax', upperInput);
