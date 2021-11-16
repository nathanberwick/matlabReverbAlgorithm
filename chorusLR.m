function output = chorusLR(inputAudio, params, Fs)

maxDelayTime = 10;%35; %ms
numberVoices = 3;
delayOffsetPercentage = 7; %between 0 and 100

delayTime  = maxDelayTime * params.chorusDepth;
lowerBound = delayTime - delayTime*(delayOffsetPercentage/100);
upperBound = delayTime + delayTime*(delayOffsetPercentage/100);

maxSampleDelays = linspace(lowerBound, upperBound, numberVoices);
maxSampleDelays = round(maxSampleDelays * (Fs/1000));

[bcoeff, acoeff] = butter(2, 20/(Fs/2), 'low'); %creates LPF

randomOffset = max(maxSampleDelays);

randomRefs  = zeros(length(maxSampleDelays),length(inputAudio));
smoothedRefs= zeros(length(maxSampleDelays),length(inputAudio));
for n = 1 : length(maxSampleDelays)
    randomRefs(n, :)   = -randomOffset + (randomOffset*2)*rand(1,length(inputAudio));
    smoothedRefs(n, :) = filter(bcoeff, acoeff, randomRefs(n, :));
end

choruses = zeros(length(maxSampleDelays),length(inputAudio));

for k=1:length(maxSampleDelays)
    for n=(maxSampleDelays(k)):length(inputAudio)
        sampleOffset=round(smoothedRefs(n));%abs(sinRef(n)); %0-1. not -1,+1
        if (n-sampleOffset > length(inputAudio))
            sampleOffset = n - length(inputAudio);
        end
        choruses(k, n) = params.chorusIntensity * inputAudio(n-sampleOffset);
    end
end

chorused = sum(choruses,1)/numberVoices;

LPF = filterGenLP(8000, Fs, 4);
chorused = filter(LPF.numerator, LPF. denominator, chorused);

output = inputAudio + chorused;