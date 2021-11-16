function output = combGainCalculate(delayTimeMs, reverbTime)

output = 10^((-3*delayTimeMs)/reverbTime);