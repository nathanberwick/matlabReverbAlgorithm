function output = ERFcCalc(delayTimeSamples, Fs)

delayTimeMs = delayTimeSamples/Fs*1000;

%boundaries
lowerInput = 0;
upperInput = 80;
lowerOutput = 16000;
upperOutput = 22050; %Fs/2, maximum cutoff

delayTimeMs = upperInput - delayTimeMs; %invert

%scale to Fc
output = rescale(delayTimeMs, lowerOutput, upperOutput, 'InputMin', lowerInput, 'InputMax', upperInput);
%still needs logarithmic scaling. for now, this works
