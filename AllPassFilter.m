function output = AllPassFilter(inputAudio, gain, sampleDelay)

output = zeros(1, length(inputAudio));
IIROutput = zeros(1, length(inputAudio));

for n=1:length(inputAudio)
    delayReadout = n - sampleDelay;

    %delayed value is the IIR filter output
    if (delayReadout > 0)
        delayedValue = gain * IIROutput(delayReadout);
        IIROutput(n) = inputAudio(delayReadout) + delayedValue;
    end
    
    output(n) = -inputAudio(n) + ((1-(gain*gain))*IIROutput(n));
end
