function output= createDelayTap(input, params, Fs)

output = zeros(1, length(input));

N = 1; %filter order
if (params.isDelayFiltered == true)
    myfilter = filterGenLP(params.delayCutoff, Fs, N);
    a = myfilter.denominator;
    b = myfilter.numerator;
end

sampleDelay = bpmToSample(params, Fs);

for n=sampleDelay+1:length(input)
    delayReadout = n - sampleDelay;
    delayedSample = params.delayLineFeedback * output(delayReadout);
    if(params.isDelayFiltered == true)
        delayedSample = filter(b, a, delayedSample);
    end
    output(n) = input(delayReadout) + delayedSample;
end