function output = createERMatrix(inputAudio, params, speedOfSound, Fs)

roomDimensions = [params.roomSize * 0.62, params.roomSize, params.roomSize * 1.62];
position       = roomDimensions / 3; %set 1/3rd of way into room
shortestLength = min(position) * 2; % *2 to get to wall and back. Assumes microphone is at same position as source

shortestLengthDelay = (shortestLength / speedOfSound) * 1000; %now in ms

if (params.latestER < shortestLengthDelay)
    output = 0;
    return;
else
    delays = linspace(shortestLengthDelay, params.latestER, params.numberERs);
end

delays = delays + params.preDelay; %add pre delay

reflections  = zeros(length(delays), length(inputAudio));
delaySamples = round(delays * (Fs/1000)); %convert to samples

%create reflections
for n=1:length(delaySamples)
    reflections(n,:) = Delay(inputAudio, delaySamples(n));
end

%filter and attenuate
for n=1:size(reflections, 1)
    Fc = ERFcCalc(delaySamples(n), Fs);
    lowpass = filterGenLP(Fc, Fs, 1); %cutoffFreq, sampleRate, order
    gain = ERAttenDelay(delays(n), params.latestER);
    gain = gain * (1 - params.absorptionCoefficient);
    reflections(n,:) = reflections(n,:) * gain;
    reflections(n,:) = filter(lowpass.numerator, lowpass.denominator, reflections(n,:));
end

%% ER EQ
preEQ = sum(reflections, 1);
postEQ = EQ(preEQ, params.ERLFGain, params.ERMidsGain, params.ERHFGain, Fs);
%% sum rows
output = postEQ;