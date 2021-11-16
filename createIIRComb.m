function output = createIIRComb(input, fbCoeff, sampleDelay, HFDamping, Fs)

output = zeros(1, length(input));

Fc = FcFromHFDamping(HFDamping);

LPF = filterGenLP(Fc, Fs, 1);
a = LPF.denominator;
b = LPF.numerator;

for n=sampleDelay+1:length(input)
    delayReadout = n - sampleDelay;
    delayedValue = fbCoeff * output(delayReadout);
    delayedValue = filter(b, a, delayedValue);
    output(n) = input(delayReadout) + delayedValue;
end